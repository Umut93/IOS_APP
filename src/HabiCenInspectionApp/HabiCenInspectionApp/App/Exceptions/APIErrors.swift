//
//  APIErrors.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 19/08/2022.
//

import Foundation

enum APIErrors: Error {
    case unauthorized(message: String)
    case unexpected(message: String? = nil)
}

extension APIErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .unauthorized(message: message):
            return "\(message)"
        case let .unexpected(message: message):
            return message == nil ? String(localized: "apiErrors.unexcecpted") : "\(message!)"
        }
    }
}
