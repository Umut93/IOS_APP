//
//  ErrorHandling.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 08/09/2022.
//

import Foundation

class ErrorHandling: ObservableObject {
    @Published var currentAlert: ErrorAlert?
    static let shared: ErrorHandling = .init()

    func handle(error: Error) {
        currentAlert = ErrorAlert(message: error.localizedDescription)
    }

    struct ErrorAlert: Identifiable {
        var id = UUID()
        var message: String
        var dismissAction: (() -> Void)?
    }
}
