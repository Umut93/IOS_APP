import Foundation

protocol InspectionStoreProtocol {
    func fetch(inspectionType: InspectionType) async -> [Inspection]
}

final class InspectionStore: InspectionStoreProtocol {
    private let apiClient: APIClient = .shared

    func fetch(inspectionType: InspectionType) async -> [Inspection] {
        let url = APIClient.createURL(endpoint: "api/v1/inspection/getinspections/\(inspectionType.rawValue)")
        do {
            let inspections: [Inspection]? = try await apiClient.get(url: url!)
            return inspections ?? []
        } catch {
            print("Could not get \(inspectionType.description)")
            print("Error: \(error)")
            return []
        }
    }
}

final class MockInspectionStore: InspectionStoreProtocol, ObservableObject {
    // swiftlint:disable:next function_body_length
    func fetch(inspectionType _: InspectionType) async -> [Inspection] {
        return [
            Inspection(
                inspectionDate: getCustomDate(year: 2000, month: 4, day: 12, hour: 1, minute: 1),
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(3600),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Pilekrogen",
                    streetNumber: "35",
                    zipCode: "1457",
                    city: "København"
                ),
                responsible: Responsible(identifier: "ncw", name: "Nikolaj Coster-Waldau"),
                inspectionType: .moveIn,
                inspectionStatus: .planned
            ),
            Inspection(inspectionDate: Date(), movingDate: Date(), inspectionDuration: TimeInterval(), tenant: Tenant(customerNo: 1111, propertyNo: 2, unitNo: 2, tenantNo: 2), lease: Lease(
                streetAddress: "Pilekrogen",
                streetNumber: "99",
                zipCode: "1460",
                city: "København"
            ), responsible: Responsible(identifier: "umut", name: "Umut Kayatuz"),
            inspectionType: .moveIn,
            inspectionStatus: .planned),
            Inspection(
                inspectionDate: getCustomDate(year: 2000, month: 5, day: 10, hour: 1, minute: 1),
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 3, propertyNo: 3, unitNo: 3, tenantNo: 3),
                lease: Lease(
                    streetAddress: "Pilekrogen",
                    streetNumber: "3000",
                    zipCode: "1457",
                    city: "København"
                ),
                responsible: nil,
                inspectionType: .moveIn,
                inspectionStatus: .notPlanned
            ),
            Inspection(
                inspectionDate: getCustomDate(year: 2010, month: 4, day: 1, hour: 1, minute: 1),
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 22, propertyNo: 222, unitNo: 2, tenantNo: 1),
                lease: Lease(
                    streetAddress: "Pilekrogen",
                    streetNumber: "35",
                    zipCode: "1457",
                    city: "København"
                ),
                responsible: nil,
                inspectionType: .moveIn,
                inspectionStatus: .notPlanned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 3, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 2232, propertyNo: 3232, unitNo: 32, tenantNo: 1234),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "27",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "ulrik", name: "Ulrik Søvsø Larsen"),
                inspectionType: .moveIn,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 900, propertyNo: 899, unitNo: 22, tenantNo: 12),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "13",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "jha", name: "Jesse Hand"),
                inspectionType: .moveIn,
                inspectionStatus: .finalized
            ),
            Inspection(
                inspectionDate: getCustomDate(year: 2001, month: 1, day: 1, hour: 1, minute: 1),
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "27",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: nil,
                inspectionType: .moveOut,
                inspectionStatus: .notPlanned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "27",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "blz", name: "Bartholomew Zhykhareiv"),
                inspectionType: .moveOut,
                inspectionStatus: .finalized
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "27",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "blz", name: "Bartholomew Zhykhareiv"),
                inspectionType: .moveOut,
                inspectionStatus: .finalized
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 2, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "100",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "blz", name: "Bartholomew Zhykhareiv"),
                inspectionType: .moveIn,
                inspectionStatus: .finalized
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 3, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "133",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "blz", name: "Bartholomew Zhykhareiv"),
                inspectionType: .moveIn,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 4, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "27",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "blz", name: "Bartholomew Zhykhareiv"),
                inspectionType: .moveOut,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "blz", name: "Bartholomew Zhykhareiv"),
                inspectionType: .moveIn,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: nil,
                inspectionType: .moveIn,
                inspectionStatus: .notPlanned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "kbh", name: "Kristian Handberg"),
                inspectionType: .moveIn,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "kbh", name: "Kristian Handberg"),
                inspectionType: .moveIn,
                inspectionStatus: .finalized
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: nil,
                inspectionType: .moveOut,
                inspectionStatus: .notPlanned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "kbh", name: "Kristian Handberg"),
                inspectionType: .moveOut,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "kbh", name: "Kristian Handberg"),
                inspectionType: .moveOut,
                inspectionStatus: .finalized
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: nil,
                inspectionType: .moveIn,
                inspectionStatus: .notPlanned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "mik", name: "Mikkel Brøgger Jensen"),
                inspectionType: .moveOut,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "mik", name: "Mikkel Brøgger Jensen"),
                inspectionType: .moveOut,
                inspectionStatus: .finalized
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: nil,
                inspectionType: .moveOut,
                inspectionStatus: .notPlanned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "mik", name: "Mikkel Brøgger Jensen"),
                inspectionType: .moveOut,
                inspectionStatus: .planned
            ),
            Inspection(
                inspectionDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                movingDate: Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!,
                inspectionDuration: TimeInterval(1337),
                tenant: Tenant(customerNo: 478, propertyNo: 924, unitNo: 342, tenantNo: 6),
                lease: Lease(
                    streetAddress: "Borgmester Jakob Jensens Gade",
                    streetNumber: "290",
                    zipCode: "8000",
                    city: "Aarhus"
                ),
                responsible: Responsible(identifier: "mik", name: "Mikkel Brøgger Jensen"),
                inspectionType: .moveOut,
                inspectionStatus: .finalized
            )
        ]
    }

    func getCustomDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var date = DateComponents()
        date.year = year
        date.month = month
        date.day = day
        date.timeZone = TimeZone(abbreviation: "Europe/Amsterdam")
        date.hour = hour
        date.minute = minute
        let userCalendar = Calendar.current
        return userCalendar.date(from: date)!
    }
}
