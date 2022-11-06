//
//  LoginView.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 11/07/2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var sceneDelegate: MainSceneDelegate
    @EnvironmentObject var appContext: AppContext
    @EnvironmentObject var authContext: AuthContext

    var body: some View {
        VStack {
            TextField("login.username", text: $authContext.username)
                .textContentType(.username)
                .frame(height: 24)
                .keyboardType(.default)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            HorizontalDivider(color: .white, thickness: 2)

            Button("login.button") {
                logIn()
            }
            .buttonStyle(LoginButtonStyle())
            .padding(.top, 16)
            .disabled(authContext.username.isEmpty)
            .opacity(authContext.username.isEmpty ? 0.5 : 1)
            .accessibilityIdentifier("login-btn")

            Button("Team Rock It") {
                fakeLogIn()
            }
            .buttonStyle(LoginButtonStyle())
            .padding(.top, 16)
            .accessibilityIdentifier("login-btn")
        }
        .padding(16)
    }

    private func logIn() {
        authContext.isFakeLogin = false

        Task {
            await authContext.login()
        }
    }

    private func fakeLogIn() {
        authContext.username = "team@rock.it"
        authContext.isFakeLogin = true
    }
}

struct LoginButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
            .cornerRadius(4.0)
    }
}
