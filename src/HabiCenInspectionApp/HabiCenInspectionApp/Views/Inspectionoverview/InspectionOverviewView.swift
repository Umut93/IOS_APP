import SwiftUI
import UIKit

struct InspectionOverviewView: View {
    @EnvironmentObject var localizationContext: LocalizationContext
    @EnvironmentObject var authContext: AuthContext
    @State private var selectedDeficiencyStatus: DeficiencyListStatus = .awaitingTenant
    @State private var selectedResponsibles: [Responsible] = []
    @State private var selectedArea: AreaSelector.Area = .inspection
    @State private var isResponsiblesSearchFieldFocused: Bool = false
    @StateObject var viewModel: InspectionOverViewModel
    @Orientation var orientation

    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }

    var body: some View {
        GeometryReader { _ in
            HStack(spacing: 0) {
                // Sidebars
                VStack {
                    if ShowUnlessResponsibleSelectorIsFocused {
                        AreaSelector(selectedArea: $selectedArea)
                    }

                    ScrollView(.vertical, showsIndicators: false) {
                        if ShowUnlessResponsibleSelectorIsFocused {
                            if selectedArea == AreaSelector.Area.inspection {
                                ShowInspectionSideBarView()
                            } else {
                                ShowDeficencySideBarView()
                            }
                        }

                        ResponsibleSelector(selections: $selectedResponsibles, isResponsiblesSearchFieldFocused: $isResponsiblesSearchFieldFocused)
                            .onChange(of: viewModel.inspections) { _ in
                                viewModel.computeFilterResult(responsibles: $selectedResponsibles)
                            }
                            .onChange(of: selectedResponsibles) { _ in
                                viewModel.computeFilterResult(responsibles: $selectedResponsibles)
                            }

                        Button("inspectionOverview.logout") {
                            logout()
                        }
                        .accessibilityIdentifier("logout-btn")
                    }
                }
                .padding([.horizontal, .top], 16)
                .frame(maxWidth: getSidebarWidth(), maxHeight: .infinity)
                .background(Color.SystemGroupedBackgroundColor.primary)

                // List view
                VStack {
                    if selectedArea == AreaSelector.Area.inspection {
                        InspectionList(
                            inspections: viewModel.getFilterInspectionsByStatus(),
                            inspectionStatus: $viewModel.selectedInspectionStatus,
                            isInspectionsLoading: $viewModel.isInspectionsLoading
                        )
                        .id(UUID())
                        .onAppear {
                            viewModel.computeFilterResult(responsibles: $selectedResponsibles)
                        }
                    } else {
                        DeficencyList(deficiencies: viewModel.filteredDeficiencies, isDefienciesLoading: $viewModel.isDeficienciesLoading).id(UUID())
                    }
                }
                .background(Color.SystemGroupedBackgroundColor.secondary)
                .cornerRadius([.topLeft], 16)
                .shadowStyle(.shadow100)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(.keyboard)
            }
        }
        .onAppear {
            self.viewModel.setUpStores(usingFakeLogin: self.authContext.isFakeLogin)
        }
    }

    private func logout() {
        if authContext.isFakeLogin {
            authContext.isFakeLogin = false
        } else {
            authContext.logout()
        }
    }

    func getSidebarWidth() -> CGFloat {
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            return UIScreen.main.bounds.width / 3
        }

        return UIScreen.main.bounds.height / 3
    }

    var ShowUnlessResponsibleSelectorIsFocused: Bool {
        if orientation.isPortrait {
            return true
        } else if !isResponsiblesSearchFieldFocused {
            return true
        }

        return false
    }

    @ViewBuilder
    func ShowInspectionSideBarView() -> some View {
        SegmentedPicker(String(localized: "inspectionOverview.picker.status"), selections: InspectionStatus.allCases, selection: $viewModel.selectedInspectionStatus) { selection in
            SegmentedLabel(selection == viewModel.selectedInspectionStatus ? .selected : .enabled) {
                Text(selection.description)
                    .font(Font.HabiCen.body)
            } badge: {
                Text(String(viewModel.getFilterInspectionsCountByStatus(inspectionStatus: selection)))
                    .font(Font.HabiCen.footnote)
            }
        }
        .padding(.bottom, 24)

        SegmentedPicker(String(localized: "inspectionOverview.picker.type"), selections: [.moveIn, .moveOut], selection: $viewModel.selectedInspectionType) { selection in
            SegmentedLabel(selection == viewModel.selectedInspectionType ? .selected : .enabled) {
                Text(selection.description)
                    .font(Font.HabiCen.body)
            } badge: {
                Text(String(viewModel.getFilterInspectionsCountByType(inspectionType: selection)))
                    .font(Font.HabiCen.footnote)
            }.onChange(of: viewModel.selectedInspectionType) { _ in
                viewModel.computeFilterResult(responsibles: $selectedResponsibles)
            }
        }
        .padding(.bottom, 24)
    }

    @ViewBuilder
    func ShowDeficencySideBarView() -> some View {
        SegmentedPicker("Status", selections: DeficiencyListStatus.allCases, selection: $viewModel.selectedDeficiencyStatus) { selection in
            SegmentedLabel(selection == viewModel.selectedDeficiencyStatus ? .selected : .enabled) {
                Text(selection.description)
                    .font(Font.HabiCen.body)
            } badge: {
                Text("+99")
                    .font(Font.HabiCen.footnote)
            }
        }.onChange(of: viewModel.selectedDeficiencyStatus) { _ in
            viewModel.fetchFilteredDeficiencies()
        }.padding(.bottom, 24)
    }
}
