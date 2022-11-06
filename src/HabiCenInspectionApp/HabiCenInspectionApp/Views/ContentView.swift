//
//  ContentView.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 06/07/2022.
//

import CoreData
import MSAL
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var sceneDelegate: MainSceneDelegate
    @EnvironmentObject private var appContext: AppContext
    @EnvironmentObject private var authContext: AuthContext

    var body: some View {
        if !authContext.accessToken.isEmptyOrWhiteSpace || authContext.isFakeLogin {
            VStack {
                InspectionOverviewView()
                    .withErrorHandling()
                    .background(Color.SystemGroupedBackgroundColor.primary)
            }
        } else {
            if authContext.isLoading {
                ProgressView()
            } else {
                LoginView()
            }
        }
    }
}
