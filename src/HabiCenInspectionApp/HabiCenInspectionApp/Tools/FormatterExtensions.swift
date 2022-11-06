//
//  FormatterExtensions.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 11/08/2022.
//

import Foundation

extension Formatter {
    static let iso8601WithFractalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    static let iso8601 = ISO8601DateFormatter()
}
