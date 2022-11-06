//
//  Color.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 14/07/2022.
//

import SwiftUI

public extension Color {
    // Base colors
    static let destructive = Color.red
    // public static let primary = Color("PrimaryColor")
    static let accentColorDark = Color("PrimaryColor")
    static let overlayBackground = Color("OverlayBackgroundColor")

    // Login colors
    static let loginBackground = Color("LoginBackground")
    static let loginButtonForeground = Color("LoginButtonForeground")
    static let loginHeaderBackground = Color("LoginHeaderBackground")

    // Task Status colors
    static let taskCellDelayed = Color("TaskCellDelayed")
    static let taskCellFinished = Color("TaskCellFinished")
    static let taskCellNotStarted = Color("TaskCellNotStarted")
    static let taskCellStarted = Color("TaskCellStarted")

    static let tagBackground = Color("TagBackground")

    // Dynamics
    static let whiteDynamic = Color("whiteDynamic")
    static let blackDynamic = Color("blackDynamic")
    static let whiteText = Color("whiteText")
    static let burgerMenu = Color("BurgerMenu")
    static let checkInOutPrimary = Color("CheckInOutPrimary")
    static let checkInOutSecondary = Color("CheckInOutSecondary")
    static let primaryToWhite = Color("PrimaryToWhite")
    static let timeRegistrationBar = Color("TimeRegistrationBar")
    static let containerHeader = Color("containerHeader")
    static let buttonOutline = Color("buttonOutline")
    static let WhiteToPrimary = Color("WhiteToPrimary")
    static let checkBox = Color("checkBox")
    static let wizardFooter = Color("wizardFooter")

    // Shades of gray 😏
    static let gray70 = Color("Gray70")
    static let gray50 = Color("Gray50")
    static let gray25 = Color("Gray25")
    static let gray10 = Color("Gray10")
    static let grayText = Color("grayText")

    // Timer colors
    static let timerRunning = Color("TimerRunning")
    static let timerPaused = Color("TimerPaused")

    // SwiftLint does not allow 1 char variable names, the extension is copied from beboerapp
    // swiftlint:disable all
    internal init(hex string: String) {
        var string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        let scanner = Scanner(string: string)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0xFF00) >> 8
        let b = (rgbValue & 0xFF)

        self.init(
            red: Double(r) / 0xFF,
            green: Double(g) / 0xFF,
            blue: Double(b) / 0xFF
        )
    }
    // swiftlint:enable all
}

public extension UIColor {
    static let primary = UIColor(named: "PrimaryColor")
    static let whiteDynamic = UIColor(named: "whiteDynamic")
    static let blackDynamic = UIColor(named: "blackDynamic")
    static let whiteText = UIColor(named: "whiteText")
    static let burgerMenu = UIColor(named: "BurgerMenu")
    static let checkInOutPrimary = UIColor(named: "CheckInOutPrimary")
    static let checkInOutSecondary = UIColor(named: "CheckInOutSecondary")
    static let primaryToWhite = UIColor(named: "PrimaryToWhite")
    static let timeRegistrationBar = UIColor(named: "TimeRegistrationBar")
    static let containerHeader = UIColor(named: "containerHeader")
    static let buttonOutline = UIColor(named: "buttonOutline")
    static let WhiteToPrimary = UIColor(named: "WhiteToPrimary")
    static let checkBox = UIColor(named: "checkBox")
    static let wizardFooter = UIColor(named: "wizardFooter")
    static let grayText = UIColor(named: "grayText")
}
