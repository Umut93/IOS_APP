//
//  ColorExtensions.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 21/07/2022.
//

import SwiftUI

extension Color {
    // Accent
    static let accent = Color("AccentColor")

    // Inspection type
    static let moveIn = Color("moveIn")
    static let moveOut = Color("moveOut")

    // Success
    static let success = Color("success")

    // systemGroupedBackgroundColor
    enum SystemGroupedBackgroundColor {
        static let primary = Color("systemGroupedBackgroundColor")
        static let secondary = Color("secondarySystemGroupedBackgroundColor")
        static let tertiary = Color("tertiarySystemGroupedBackgroundColor")
    }

    // systemBackgroundColor
    enum SystemBackgroundColor {
        static let primary = Color(uiColor: .systemBackground)
        static let secondary = Color(uiColor: .secondarySystemBackground)
        static let tertiary = Color(uiColor: .tertiarySystemBackground)
    }

    // systemFill
    enum SystemFill {
        static let primary = Color(uiColor: .systemFill)
        static let secondary = Color(uiColor: .secondarySystemFill)
        static let tertiary = Color(uiColor: .tertiarySystemFill)
        static let quaternary = Color(uiColor: .quaternarySystemFill)
    }

    // label
    enum Label {
        static let primary = Color(uiColor: .label)
        static let secondary = Color(uiColor: .secondaryLabel)
        static let tertiary = Color(uiColor: .tertiaryLabel)
        static let quaternary = Color(uiColor: .quaternaryLabel)
    }

    // separator
    enum Separator {
        static let opaque = Color(uiColor: .opaqueSeparator)
        static let nonOpaque = Color(uiColor: .separator)
    }

    // placeholder
    enum PlaceholderText {
        static let placeholderText = Color(uiColor: .placeholderText)
    }

    // systemGray
    enum SystemGray {
        static let systemBlack = Color(uiColor: .black)
        static let systemGray = Color(uiColor: .systemGray)
        static let systemGray2 = Color(uiColor: .systemGray2)
        static let systemGray3 = Color(uiColor: .systemGray3)
        static let systemGray4 = Color(uiColor: .systemGray4)
        static let systemGray5 = Color(uiColor: .systemGray5)
        static let systemGray6 = Color(uiColor: .systemGray6)
        static let systemWhite = Color(uiColor: .white)
    }

    // Gradient
    static let gradient = LinearGradient(
        colors: [
            Color("sidebarColor"),
            Color("sidebarTransparent")
        ],
        startPoint: .bottom,
        endPoint: .top
    )
}
