//
//  AppContext.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 12/07/2022.
//

import Foundation

@MainActor final class AppContext: ObservableObject {
    static let shared: AppContext = .init()

    @Published private(set) var userContext: UserContext?
    @Published private(set) var authContext: AuthContext = .shared
    @Published private(set) var localizationContext: LocalizationContext = .init()
}
