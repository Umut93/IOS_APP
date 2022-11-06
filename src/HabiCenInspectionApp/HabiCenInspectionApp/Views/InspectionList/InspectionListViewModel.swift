//
//  InspectionOverViewViewModel.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 04/08/2022.
//
import SwiftUI

extension InspectionList {
    @MainActor class InspectionListViewModel: ObservableObject {
        @Published var inspectionGrouping: [(key: Date, value: [Inspection])] = .init()
        @Published var inspections: [Inspection] = .init()
        @Binding var selectedInspectionStatus: InspectionStatus

        init(inspections: [Inspection], inspectionStatus: Binding<InspectionStatus>) {
            _selectedInspectionStatus = inspectionStatus
            self.inspections.append(contentsOf: inspections)
            initInspectionGrouping(inspections: self.inspections)
        }

        func initInspectionGrouping(inspections: [Inspection]) {
            if selectedInspectionStatus == .notPlanned {
                inspectionGrouping = Dictionary(grouping: inspections, by: { Calendar.current.startOfDay(for: getCustomDate(inspectionDate: $0.movingDate)) }).sorted(by: { $0.key < $1.key })
            } else {
                inspectionGrouping = Dictionary(grouping: inspections, by: { Calendar.current.startOfDay(for: $0.inspectionDate!) }).sorted(by: { $0.key < $1.key })
            }
        }

        func filterBasedOnSearch(searchText: String) {
            if !searchText.isEmptyOrWhiteSpace {
                let filteredInspections = inspections
                    .filter {
                        $0.responsible?.name.lowercased().contains(searchText.lowercased()) ?? false ||
                            $0.lease?.getFullAddress().lowercased().contains(searchText.lowercased()) ?? false ||
                            $0.tenant?.getLeaseNumber().contains(searchText) ?? false
                    }
                initInspectionGrouping(inspections: filteredInspections)
            } else {
                initInspectionGrouping(inspections: inspections)
            }
        }

        func getCustomDate(inspectionDate: Date?) -> Date {
            let userCalendar = Calendar.current
            var date = DateComponents()
            date.year = inspectionDate == nil ? 1 : Int(DateFormatter.yyyy.string(from: inspectionDate!))
            date.timeZone = TimeZone(abbreviation: "Europe/Amsterdam")
            return userCalendar.date(from: date)!
        }
    }
}
