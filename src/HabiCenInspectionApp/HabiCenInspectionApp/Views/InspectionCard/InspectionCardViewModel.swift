// InspectionCardViewModel.swift
// HabiCenInspectionApp

// Created by Umut Kayatuz on 09/08/2022.

import SwiftUI

final class InspectionCardViewModel: ObservableObject {
    @Published var inspection: Inspection

    init(inspection: Inspection) {
        self.inspection = inspection
    }

    func getTitle() -> String {
        switch inspection.inspectionStatus {
        case .planned, .finalized:
            return inspection.inspectionDate?.formatToString(using: .HHmm) ?? String(localized: "inspectionCard.title.planned")
        case .notPlanned:
            return inspection.movingDate?.formatToString(using: .ddMMM) ?? String(localized: "inspectionCard.title.notPlanned")
        }
    }

    func getTitleFont() -> Font {
        return Font.HabiCen.title3Bold
    }

    func getInspectionColor() -> Color {
        switch inspection.inspectionType {
        case .moveIn:
            return Color.moveIn
        case .moveOut:
            return Color.moveOut
        }
    }

    func getInspectionText() -> String {
        switch inspection.inspectionType {
        case .moveIn:
            return String(localized: "inspectionCard.title.moveIn")
        case .moveOut:
            return String(localized: "inspectionCard.title.moveOut")
        }
    }

    func getSubtitle() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        let formattedNumber = formatter.string(from: inspection.inspectionDuration)!
        return formattedNumber
    }
}

extension InspectionCardViewModel {
    enum InspectionCardMode {
        case planned
        case notPlanned
    }
}
