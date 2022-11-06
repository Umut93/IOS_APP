//
//  app_habicen_inspection_swiftApp.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 06/07/2022.
//

import SwiftUI

@main
struct HabicenInspectionApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    @StateObject private var appContext: AppContext = .shared
    @StateObject private var errorHandling: ErrorHandling = .shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .withErrorHandling()
                .onAppear {
                    Task {
                        await appContext.authContext.login()
                    }
                }
                .environmentObject(appContext)
                .environmentObject(appContext.authContext)
                .environmentObject(appContext.localizationContext)
                .environmentObject(errorHandling)
        }
    }
}
