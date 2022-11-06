//
//  DeficencyList.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 11/08/2022.
//

import SwiftUI

struct DeficencyList: View {
    @StateObject var viewModel: DeficencyListViewModel
    @State var searchQuery: String = .init()
    @Binding var isDefienciesLoading: Bool

    init(deficiencies: [Deficiency], isDefienciesLoading: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: .init(deficiencies: deficiencies))
        _isDefienciesLoading = isDefienciesLoading
    }

    var body: some View {
        SearchField(searchText: $searchQuery, placeholder: String(localized: "inspectionOverview.list.searchField.deficiency.placeholder"))
            .padding(.top, 20)
            .padding(.horizontal, 20)

        if isDefienciesLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .scaleEffect(1.5, anchor: .center)
        } else if viewModel.filteredDeficiencies.isEmpty && !isDefienciesLoading {
            VStack {
                Text(String(localized: "inspectionOverview.emptydeficiencylist"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .font(Font.title).foregroundColor(.gray)
                    .padding(.horizontal, 20)
            }
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 8) {
                    VStack {
                        ForEach(viewModel.filteredDeficiencies, id: \.self) { deficiency in
                            DeficencyCard(defiency: deficiency)
                        }
                    }
                    .padding(.top, 4) // 12 - spacing = 4
                }
                Spacer(minLength: 12)
            }.onChange(of: searchQuery) { _ in
                viewModel.filterBasedOnSearch(searchText: searchQuery)
            }
        }
    }

    private func getTitle(for inspectionDate: Date) -> String {
        return inspectionDate.formatToString(using: .EEEEddMMMM).capitalized
    }

    private func getSubtitle(for inspectionDate: Date) -> String? {
        return Calendar.current.isDateInToday(inspectionDate)
            ? String(localized: "inspectionOverview.list.header.subtitle")
            : nil
    }

    private func createHeaderView(_ title: String, subtitle: String? = nil) -> some View {
        HStack {
            HStack {
                Text(title)
                    .padding([.bottom], 8)
                    .foregroundColor(.Label.primary)
                    .font(.HabiCen.bodyBold)

                if let subtitle = subtitle {
                    Text(subtitle)
                        .padding([.bottom], 8)
                        .foregroundColor(.Label.secondary)
                        .font(.HabiCen.body)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .border(width: 1, edges: [.bottom], color: Color.Separator.opaque)
        }
        .padding(.horizontal, 20)
        .background(Color.SystemGroupedBackgroundColor.secondary)
    }
}
