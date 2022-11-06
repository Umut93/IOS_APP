//
//  StringExtensions.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 06/07/2022.
//

import Foundation

extension String {
    func localized(language: String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }

    var isEmptyOrWhiteSpace: Bool {
        return isEmpty || trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension String {
    enum Awesome {
        static var User = "user"
        static var Location = "location-dot"
        static var House = "house"
    }
}
