//
//  HandleErrorsByShowingAlertViewModifier.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 08/09/2022.
//

import SwiftUI

struct HandleErrorsByShowingAlertViewModifier: ViewModifier {
    @StateObject var errorHandling: ErrorHandling = .shared

    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandling)
            // Applying the alert for error handling using a background element
            // is a workaround, if the alert would be applied directly,
            // other .alert modifiers inside of content would not work anymore
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text("Error"),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}

extension View {
    func withErrorHandling() -> some View {
        modifier(HandleErrorsByShowingAlertViewModifier())
    }
}
