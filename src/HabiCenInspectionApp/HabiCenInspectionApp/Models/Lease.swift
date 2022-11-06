struct Lease: Codable, Hashable, Equatable {
    let streetAddress: String
    let streetNumber: String
    let zipCode: String
    let city: String

    func getFullAddress() -> String {
        return "\(streetAddress) \(streetNumber), \(zipCode) \(city)"
    }
}
