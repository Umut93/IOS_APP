//
//  InspectionOverviewViewModel.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 10/08/2022.
//

import Foundation
import SwiftUI

@MainActor final class InspectionOverViewModel: ObservableObject {
    private var inspectionStore: InspectionStoreProtocol!
    private var deficiencyStore: DeficiencyStoreProtocol!
    @Published var inspections: [Inspection] = []
    private var deficiencies: [Deficiency] = []
    @Published var filteredResponsibleInspections: [Inspection] = []
    @Published var filteredMoveInInspections: [Inspection] = []
    @Published var filteredMoveOutInspections: [Inspection] = []
    @Published var filteredDeficiencies: [Deficiency] = []
    @Published var filteredNotPlannedInspections: [Inspection] = []
    @Published var filteredPlannedInspections: [Inspection] = []
    @Published var filteredFinalizedInspections: [Inspection] = []
    @Published var selectedInspectionStatus: InspectionStatus = .notPlanned
    @Published var selectedDeficiencyStatus: DeficiencyListStatus = .awaitingTenant
    @Published var selectedInspectionType: InspectionType = .moveIn
    @Published var isInspectionsLoading: Bool = true
    @Published var isDeficienciesLoading: Bool = true
    private var errorHandling: ErrorHandling = .shared

    init() {
        // Remember to call setupStores!
    }

    func setUpStores(usingFakeLogin isFakeLogin: Bool) {
        inspectionStore = isFakeLogin ? MockInspectionStore() : InspectionStore()
        deficiencyStore = isFakeLogin ? MockDeficiencyStore() : DeficiencyStore()
        do {
            try fetchInspections()
            try fetchDeficiencies()
        } catch {
            errorHandling.handle(error: error)
        }
    }

    func fetchInspections() throws {
        guard let inspectionStore = inspectionStore else {
            throw InspectionOverviewErrors.storeNotInitialized
        }
        Task {
            inspections.append(contentsOf: await inspectionStore.fetch(inspectionType: .moveIn))
            inspections.append(contentsOf: await inspectionStore.fetch(inspectionType: .moveOut))
            isInspectionsLoading = false
        }
    }

    func fetchDeficiencies() throws {
        guard let deficiencyStore = deficiencyStore else {
            throw InspectionOverviewErrors.storeNotInitialized
        }

        Task {
            deficiencies = await deficiencyStore.fetch()
            fetchFilteredDeficiencies()
            isDeficienciesLoading = false
        }
    }

    func fetchFilteredDeficiencies() {
        filteredDeficiencies = deficiencies.filter { $0.deficiencyListStatus == selectedDeficiencyStatus }
    }

    func computeFilterResult(responsibles: Binding<[Responsible]>) {
        filteredResponsibleInspections = inspections.filter { inspection in
            responsibles.isEmpty ||
                inspection.inspectionStatus == .notPlanned ||
                responsibles.contains { responsible in
                    inspection.responsible == responsible.wrappedValue
                }
        }

        filteredMoveInInspections = filteredResponsibleInspections.filter { $0.inspectionType == .moveIn }
        filteredMoveOutInspections = filteredResponsibleInspections.filter { $0.inspectionType == .moveOut }

        filteredNotPlannedInspections = filteredResponsibleInspections.filter { $0.inspectionStatus == .notPlanned && $0.inspectionType == selectedInspectionType }
        filteredPlannedInspections = filteredResponsibleInspections.filter { $0.inspectionStatus == .planned && $0.inspectionType == selectedInspectionType }
        filteredFinalizedInspections = filteredResponsibleInspections.filter { $0.inspectionStatus == .finalized && $0.inspectionType == selectedInspectionType }
    }

    func getFilterInspectionsByStatus() -> [Inspection] {
        switch selectedInspectionStatus {
        case .notPlanned:
            return filteredNotPlannedInspections
        case .planned:
            return filteredPlannedInspections
        case .finalized:
            return filteredFinalizedInspections
        }
    }

    func getFilterInspectionsCountByType(inspectionType: InspectionType) -> Int {
        switch inspectionType {
        case .moveIn:
            return filteredMoveInInspections.count
        case .moveOut:
            return filteredMoveOutInspections.count
        }
    }

    func getFilterInspectionsCountByStatus(inspectionStatus: InspectionStatus) -> Int {
        switch inspectionStatus {
        case .notPlanned:
            return filteredNotPlannedInspections.count
        case .planned:
            return filteredPlannedInspections.count
        case .finalized:
            return filteredFinalizedInspections.count
        }
    }
}
