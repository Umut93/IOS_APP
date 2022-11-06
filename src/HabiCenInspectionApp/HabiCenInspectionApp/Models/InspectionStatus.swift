enum InspectionStatus: Int, CaseIterable, CustomStringConvertible, Equatable, Hashable, Codable {
    case notPlanned
    case planned
    case finalized

    var description: String {
        switch self {
        case .notPlanned: return String(localized: "inspectionStatus.description.notPlanned")
        case .planned: return String(localized: "inspectionStatus.description.planned")
        case .finalized: return String(localized: "inspectionStatus.description.finalized")
        }
    }
}
