//
//  SecureStore.swift
//  iDrift
//
//  Created by Allan Eriksen on 09/08/2019.
//  Copyright © 2019 Logicmedia. All rights reserved.
//

import Foundation
import Security

public struct SecureStore {
    let secureStoreQueryable: SecureStoreQueryable

    public init(secureStoreQueryable: SecureStoreQueryable) {
        self.secureStoreQueryable = secureStoreQueryable
    }

    public func setValue(_ value: String, for userAccount: String) throws {
        // 1
        guard let encodedPassword = value.data(using: .utf8) else {
            throw SecureStoreError.string2DataConversionError
        }

        // 2
        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = userAccount
        query[String(kSecAttrAccessible)] = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly

        // 3
        var status = SecItemCopyMatching(query as CFDictionary, nil)

        switch status {
            // 4
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedPassword

            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)

            if status == errSecItemNotFound {
                query[String(kSecAttrAccessible)] = kSecAttrAccessibleWhenUnlocked
                _ = SecItemDelete(query as CFDictionary)
                query[String(kSecAttrAccessible)] = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
                status = SecItemAdd(query as CFDictionary, nil)
            }

            if status != errSecSuccess {
                throw error(from: status)
            }
            // 5
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodedPassword

            status = SecItemAdd(query as CFDictionary, nil)

            if status == errSecDuplicateItem {
                query[String(kSecAttrAccessible)] = kSecAttrAccessibleWhenUnlocked
                _ = SecItemDelete(query as CFDictionary)
                query[String(kSecAttrAccessible)] = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
                status = SecItemAdd(query as CFDictionary, nil)
            }

            if status != errSecSuccess {
                throw error(from: status)
            }
        default:
            throw error(from: status)
        }
    }

    public func getValue(for userAccount: String) throws -> String? {
        // 1
        var query = secureStoreQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(kSecAttrAccount)] = userAccount

        // 2
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, $0)
        }

        switch status {
            // 3
        case errSecSuccess:
            guard
                let queriedItem = queryResult as? [String: Any],
                let passwordData = queriedItem[String(kSecValueData)] as? Data,
                let password = String(data: passwordData, encoding: .utf8)
            else {
                throw SecureStoreError.data2StringConversionError
            }
            return password
            // 4
        case errSecItemNotFound:
            return nil
        default:
            throw error(from: status)
        }
    }

    public func removeValue(for userAccount: String) throws {
        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = userAccount

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }

    public func removeAllValues() throws {
        let query = secureStoreQueryable.query

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }

    private func error(from status: OSStatus) -> SecureStoreError {
        let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
        return SecureStoreError.unhandledError(message: message)
    }
}
