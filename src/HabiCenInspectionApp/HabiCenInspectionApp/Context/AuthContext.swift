//
//  MSALContext.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 12/07/2022.
//

import Foundation
import MSAL
import UIKit

@MainActor final class AuthContext: ObservableObject {
    static let shared: AuthContext = .init()

    @Published var currentAccount: MSALAccount?
    @Published var isFakeLogin: Bool = false
    @Published var username: String = ""
    @Published var isLoading: Bool = false

    var accessToken: String = ""

    private var expirationTime: Date?

    private let msalApplication: MSALPublicClientApplication?
    private var webViewParameters: MSALWebviewParameters? { return MSALWebviewParameters(authPresentationViewController: MainSceneDelegate.shared.rootViewController!) }

    private let b2cTenantName = "bolaadb2cd"
    private let b2cSigninPolicyName = "B2C_1A_SIGNIN_SIGNUP"
    private let b2cClientId = "63b2789e-90fd-48b0-86a0-ae9d5d405fec"
    private let scopes: [String] = ["63b2789e-90fd-48b0-86a0-ae9d5d405fec"]
    private let secureStore: SecureStore

    init() {
        let signUpOrLogInAuthorityURL = URL(
            string:
            "https://\(b2cTenantName).b2clogin.com/\(b2cTenantName).onmicrosoft.com/\(b2cSigninPolicyName)"
        )!

        // swiftlint:disable:next force_try
        let authority = try! MSALB2CAuthority(url: signUpOrLogInAuthorityURL)
        let pcaConfig = MSALPublicClientApplicationConfig(
            clientId: b2cClientId,
            redirectUri: "msauth.unik.habiceninspection.swift://auth",
            authority: authority
        )

        pcaConfig.knownAuthorities = [authority]

        // swiftlint:disable:next force_try
        msalApplication = try! MSALPublicClientApplication(configuration: pcaConfig)

        secureStore = SecureStore(secureStoreQueryable: GenericPasswordQueryable(service: "HabiCenInspection"))

        if let username = getStoredUsername() {
            self.username = username
        }
    }

    func login() async {
        isLoading = true
        await loadCurrentAccount { account in
            guard let currentAccount = account else {
                await self.acquireTokenInteractively()
                self.isLoading = false
                return
            }

            await self.acquireTokenSilently(currentAccount)
            self.isLoading = false
        }
    }

    func acquireTokenInteractively() async {
        guard let applicationContext = msalApplication else {
            return
        }
        guard let webViewParameters = webViewParameters else {
            return
        }

        let parameters = MSALInteractiveTokenParameters(scopes: scopes, webviewParameters: webViewParameters)
        parameters.promptType = .selectAccount
        parameters.loginHint = username

        do {
            let result = try await applicationContext.acquireToken(with: parameters)

            saveUsername(result: result)
            setExpirationTime(result: result)

            accessToken = result.accessToken
            currentAccount = result.account

            print("Acquired token: \(accessToken)")
        } catch {
            print("Could not acquire token: \(error)")
            return
        }
    }

    func acquireTokenSilently(_ account: MSALAccount!) async {
        guard let applicationContext = msalApplication else {
            return
        }

        let parameters = MSALSilentTokenParameters(scopes: scopes, account: account)

        do {
            let result = try await applicationContext.acquireTokenSilent(with: parameters)

            saveUsername(result: result)
            setExpirationTime(result: result)

            accessToken = result.accessToken
            currentAccount = result.account

            print("Acquired token: \(accessToken)")
        } catch {
            let nsError = error as NSError
            if nsError.domain == MSALErrorDomain {
                if nsError.code == MSALError.interactionRequired.rawValue {
                    await acquireTokenInteractively()
                }
                return
            }
            print("Could not acquire token silently: \(error)")
            return
        }
    }

    func logout() {
        guard let applicationContext = msalApplication else {
            return
        }

        guard let account = currentAccount else {
            return
        }

        do {
            let signoutParameters = MSALSignoutParameters(webviewParameters: webViewParameters!)
            signoutParameters.signoutFromBrowser = false

            applicationContext.signout(with: account, signoutParameters: signoutParameters) { _, error in
                if let error = error {
                    print("Couldn't sign out account with error: \(error)")
                    return
                }

                self.accessToken = ""
                self.currentAccount = nil
                self.username = ""
                self.deleteStoredUsername()
            }
        }
    }

    typealias AccountCompletion = (MSALAccount?) async -> Void
    func loadCurrentAccount(completion: AccountCompletion? = nil) async {
        guard let applicationContext = msalApplication else {
            return
        }

        let msalParameters = MSALParameters()
        msalParameters.completionBlockQueue = DispatchQueue.main

        do {
            let (currentAccount, previousAccount) = try await applicationContext.getCurrentAccount(with: msalParameters)

            if let currentAccount = currentAccount {
                print("Found a signed in account \(String(describing: currentAccount.username)). Updating data for that account...")
                self.currentAccount = currentAccount

                if let completion = completion {
                    await completion(self.currentAccount)
                }

                return
            }

            if let previousAccount = previousAccount {
                print("The account with username \(String(describing: previousAccount.username)) has been signed out.")
            } else {
                print("Account signed out.")
            }

            accessToken = ""
            self.currentAccount = nil

            if let completion = completion {
                await completion(nil)
            }
        } catch {
            print("Couldn't query current account with error: \(error)")
            return
        }
    }

    func setExpirationTime(result: MSALResult) {
        guard let expirationTime = result.tenantProfile.claims?["exp"] else {
            return
        }

        self.expirationTime = Date(timeIntervalSince1970: TimeInterval(Double(String(describing: expirationTime))!))
    }

    func isTokenExpired() -> Bool {
        guard let expirationTime = expirationTime else {
            return true
        }

        if expirationTime < Date.now {
            return true
        }

        return false
    }

    func saveUsername(result: MSALResult) {
        guard let username = result.tenantProfile.claims?["enteredEmail"] else {
            print("Could not find username in result")
            return
        }

        self.username = String(describing: username)

        do {
            try secureStore.setValue(String(describing: username), for: SecureStoreItemKey.username.rawValue)
        } catch {
            print("Could not store username")
        }
    }

    func deleteStoredUsername() {
        do {
            try secureStore.removeValue(for: SecureStoreItemKey.username.rawValue)
        } catch {
            print("Could not remove username")
        }
    }

    func getStoredUsername() -> String? {
        do {
            let username = try secureStore.getValue(for: SecureStoreItemKey.username.rawValue)
            return username
        } catch {
            print("Could find username")
            return nil
        }
    }
}

enum SecureStoreItemKey: String {
    case username = "Username"
}

extension MSALPublicClientApplication {
    func getCurrentAccount(with msalParameters: MSALParameters) async throws -> (MSALAccount?, MSALAccount?) {
        try await withCheckedThrowingContinuation { continuation in
            self.getCurrentAccount(with: msalParameters) { currentAccount, previousAccount, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: (currentAccount, previousAccount))
                }
            }
        }
    }
}
