//
//  DeficencyList.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 11/08/2022.
//

import Foundation

extension DeficencyList {
    @MainActor class DeficencyListViewModel: ObservableObject {
        @Published var inspectionGrouping: [(key: Date, value: [Deficiency])] = .init()
        @Published var filteredDeficiencies: [Deficiency] = []
        private let deficiencies: [Deficiency]

        init(deficiencies: [Deficiency]) {
            self.deficiencies = deficiencies
            filteredDeficiencies = deficiencies
        }

        func filterBasedOnSearch(searchText: String) {
            if !searchText.isEmptyOrWhiteSpace {
                filteredDeficiencies = deficiencies
                    .filter {
                        $0.responsible?.name.lowercased().contains(searchText.lowercased()) ?? false ||
                            $0.lease?.getFullAddress().lowercased().contains(searchText.lowercased()) ?? false ||
                            $0.tenant?.getLeaseNumber().contains(searchText) ?? false
                    }
            } else {
                filteredDeficiencies = deficiencies
            }
        }
    }
}
