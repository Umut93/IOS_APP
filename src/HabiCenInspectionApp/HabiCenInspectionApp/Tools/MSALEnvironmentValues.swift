//
//  MSAL.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 12/07/2022.
//

import MSAL
import SwiftUI

private struct MSALPublicClientApplicationKey: EnvironmentKey {
    static var defaultValue: MSALPublicClientApplication = .init()
}

extension EnvironmentValues {
    var msalApplication: MSALPublicClientApplication {
        get { self[MSALPublicClientApplicationKey.self] }
        set { self[MSALPublicClientApplicationKey.self] = newValue }
    }
}
