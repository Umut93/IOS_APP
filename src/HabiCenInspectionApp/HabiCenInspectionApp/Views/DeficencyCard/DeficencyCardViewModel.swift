//
//  DeficencyCardViewModel.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 10/08/2022.
//

import Foundation

// DefiencyCardViewModel.swift
// HabiCenInspectionApp

// Created by Umut Kayatuz on 09/08/2022.

import SwiftUI

@MainActor final class DefiencyCardViewModel: ObservableObject {
    @Published var deficiency: Deficiency
    private var appContext: AppContext = .shared

    init(defiency: Deficiency) {
        deficiency = defiency
    }

    public var mode: DefiencyCardCardMode {
        switch deficiency.deficiencyListStatus {
        case .awatingResponsible:
            return .awaitingResponsible
        case .awaitingTenant:
            return .awaitingTenant
        }
    }

    func getTitle() -> String {
        switch mode {
        case .awaitingTenant:
            return String(localized: "deficiencyCard.title.awaitingTenant")
        case .awaitingResponsible:
            return deficiency.inspectionDate?.formatToString(using: .ddMMM) ?? String(localized: "deficiencyCard.title.awaitingResponsible")
        }
    }

    func getInspectionColor() -> Color {
        switch deficiency.deficiencyListStatus {
        case .awatingResponsible:
            return Color.success
        case .awaitingTenant:
            return Color.Label.secondary
        }
    }

    func getInspectionText() -> String {
        switch deficiency.deficiencyListStatus {
        case .awaitingTenant:
            return "14 dage tilbage" // TODO: Get real data
        case .awatingResponsible:
            return String(localized: "deficiencyCard.inspectionText.awaitingResponsible \(deficiency.elementCount)")
        }
    }

    func getTitleFont() -> Font {
        return mode == DefiencyCardCardMode.awaitingTenant ? Font.HabiCen.headlineBold : Font.HabiCen.title3Bold
    }
}

extension DefiencyCardViewModel {
    enum DefiencyCardCardMode {
        case awaitingTenant
        case awaitingResponsible
    }
}
