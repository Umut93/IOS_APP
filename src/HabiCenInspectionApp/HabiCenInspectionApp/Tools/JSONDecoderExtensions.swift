//
//  JSONDecoderExtensions.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 11/08/2022.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static let iso8601WithFractalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)

        if let date = Formatter.iso8601WithFractalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
