//
//  LocalizationContext.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 12/07/2022.
//

import Foundation

final class LocalizationContext: ObservableObject {
    static let defaultLocale: Localization = Localization("da")
    @Published var selectedLocale: String = defaultLocale.id
    @Published var supportedLocales: [Localization] = {
        let bundle = Bundle.main
        return bundle.localizations.map { Localization($0) }
    }()

    init() {
        selectedLocale = (LocalizationContext.getDefaultLocaleIfSupportedElseFirst(supportedLocales: supportedLocales)).id
    }

    static func getDefaultLocaleIfSupportedElseFirst(supportedLocales: [Localization]) -> Localization {
        let defaultLocale = supportedLocales.first(where: { $0.identifier == LocalizationContext.defaultLocale.identifier })
        let firstLocale = supportedLocales.first
        return defaultLocale ?? firstLocale ?? LocalizationContext.defaultLocale
    }
}

struct Localization: Identifiable, Hashable {
    let id: String
    let identifier: String

    init(_ identifier: String) {
        self.id = identifier
        self.identifier = identifier
    }
}
