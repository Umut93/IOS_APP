//
//  MainSceneDelegate.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 11/07/2022.
//

import UIKit

final class MainSceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    var window: UIWindow?
    var rootViewController: UIViewController?
    static var shared: MainSceneDelegate! = nil

    override init() {
        super.init()
        Self.shared = self
    }

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        window = windowScene.keyWindow
        rootViewController = window?.rootViewController
    }
}
