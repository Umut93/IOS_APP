import Foundation

protocol DeficiencyStoreProtocol {
    func fetch() async -> [Deficiency]
}

final class DeficiencyStore: DeficiencyStoreProtocol {
    private let apiClient: APIClient = .shared

    func fetch() async -> [Deficiency] {
        let url = APIClient.createURL(endpoint: "api/v1/inspection/getdeficiencylists")

        do {
            let deficiencies: [Deficiency]? = try await apiClient.get(url: url!)
            return deficiencies ?? []

        } catch {
            print("Could not get deficiency lists")
            print("Error: \(error)")
            return []
        }
    }
}

final class MockDeficiencyStore: DeficiencyStoreProtocol {
    func fetch() async -> [Deficiency] {
        return [
            Deficiency(
                inspectionId: 1,
                inspectionDate: Date.now, inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 100, propertyNo: 55, unitNo: 11, tenantNo: 1),
                lease: Lease(streetAddress: "Pilekrogen", streetNumber: "99", zipCode: "1458", city: "København"),
                responsible: Responsible(identifier: "jes", name: "Jesper"), elementCount: 1, deficiencyListStatus: .awatingResponsible
            ),
            Deficiency(
                inspectionId: 2,
                inspectionDate: Date.now, inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 101, propertyNo: 56, unitNo: 12, tenantNo: 1),
                lease: Lease(streetAddress: "Pilekrogen", streetNumber: "800", zipCode: "1457", city: "København"),
                responsible: Responsible(identifier: "jan", name: "Jan"), elementCount: 1, deficiencyListStatus: .awatingResponsible
            ),
            Deficiency(
                inspectionId: 3,
                inspectionDate: Date.now,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 102, propertyNo: 57, unitNo: 13, tenantNo: 1),
                lease: Lease(streetAddress: "Asmild Vænge", streetNumber: "1", zipCode: "8800", city: "Viborg"),
                responsible: Responsible(identifier: "lrs", name: "Lars"), elementCount: 1, deficiencyListStatus: .awaitingTenant
            )
        ]
    }
}
