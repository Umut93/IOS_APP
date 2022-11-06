//
//  DeficiencyList.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 10/08/2022.
//

import Foundation

struct Deficiency: Codable, Hashable {
    let inspectionId: Int
    let elementCount: Int
    let inspectionDate: Date?
    let inspectionDuration: TimeInterval
    let tenant: Tenant?
    let lease: Lease?
    let responsible: Responsible?
    let deficiencyListStatus: DeficiencyListStatus

    init(
        inspectionId: Int,
        inspectionDate: Date,
        inspectionDuration: TimeInterval,
        tenant: Tenant,
        lease: Lease,
        responsible: Responsible,
        elementCount: Int,
        deficiencyListStatus: DeficiencyListStatus
    ) {
        self.inspectionId = inspectionId
        self.inspectionDate = inspectionDate
        self.inspectionDuration = inspectionDuration
        self.elementCount = elementCount
        self.tenant = tenant
        self.lease = lease
        self.responsible = responsible
        self.deficiencyListStatus = deficiencyListStatus
    }
}
