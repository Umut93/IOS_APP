enum DeficiencyListStatus: Int, CaseIterable, CustomStringConvertible, Codable {
    case awaitingTenant
    case awatingResponsible

    var description: String {
        switch self {
        case .awaitingTenant: return String(localized: "deficiencyListStatus.description.awaitingTenant")
        case .awatingResponsible: return String(localized: "deficiencyListStatus.description.awaitingResponsible")
        }
    }
}
