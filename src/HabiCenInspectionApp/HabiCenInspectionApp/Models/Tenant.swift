struct Tenant: Codable, Hashable, Equatable {
    let customerNo: Int
    let propertyNo: Int
    let unitNo: Int
    let tenantNo: Int

    func getLeaseNumber() -> String {
        return "\(customerNo)-\(propertyNo)-\(unitNo)-\(tenantNo)"
    }
}
