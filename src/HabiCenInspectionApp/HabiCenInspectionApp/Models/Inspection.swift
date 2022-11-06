import Foundation

struct Inspection: Codable, Hashable, Equatable {
    let inspectionDate: Date?
    let movingDate: Date?
    let inspectionDuration: TimeInterval
    let tenant: Tenant?
    let lease: Lease?
    let responsible: Responsible?
    let inspectionType: InspectionType
    let inspectionStatus: InspectionStatus

    init(
        inspectionDate: Date?,
        movingDate: Date?,
        inspectionDuration: TimeInterval,
        tenant: Tenant?,
        lease: Lease?,
        responsible: Responsible?,
        inspectionType: InspectionType,
        inspectionStatus: InspectionStatus
    ) {
        self.inspectionDate = inspectionDate
        self.movingDate = movingDate
        self.inspectionDuration = inspectionDuration
        self.tenant = tenant
        self.lease = lease
        self.responsible = responsible
        self.inspectionType = inspectionType
        self.inspectionStatus = inspectionStatus
    }
}
