import SwiftUI

enum InspectionType: Int, CaseIterable, CustomStringConvertible, Codable {
    case moveIn
    case moveOut

    var description: String {
        switch self {
        case .moveIn: return String(localized: "inspectionType.description.moveIn")
        case .moveOut: return String(localized: "inspectionType.description.moveOut")
        }
    }
}
