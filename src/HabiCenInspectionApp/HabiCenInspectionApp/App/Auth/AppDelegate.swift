//
//  AppDelegate.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 11/07/2022.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(
            name: "MainScene",
            sessionRole: .windowApplication
        )
        configuration.delegateClass = MainSceneDelegate.self
        #if DEBUG
        Watchdog.shared.start()
        #endif
        return configuration
    }
}
