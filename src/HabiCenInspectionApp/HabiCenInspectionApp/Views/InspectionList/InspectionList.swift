import SwiftUI

struct InspectionList: View {
    @StateObject var viewModel: InspectionListViewModel
    @State var searchQuery: String = .init()
    @Binding var isInspectionsLoading: Bool

    init(inspections: [Inspection], inspectionStatus: Binding<InspectionStatus>, isInspectionsLoading: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: .init(inspections: inspections, inspectionStatus: inspectionStatus))
        _isInspectionsLoading = isInspectionsLoading
    }

    var body: some View {
        SearchField(searchText: $searchQuery, placeholder: String(localized: "inspectionOverview.list.searchField.inspection.placeholder"))
            .padding(.top, 20)
            .padding(.horizontal, 20)

        if isInspectionsLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .scaleEffect(1.5, anchor: .center)
        } else if viewModel.inspectionGrouping.isEmpty && !isInspectionsLoading {
            Text(String(localized: "inspectionOverview.emptyinspectionlist"))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(Font.title).foregroundColor(.gray)
                .padding(.horizontal, 20)
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 8, pinnedViews: [.sectionHeaders]) {
                    ForEach(viewModel.inspectionGrouping, id: \.key) { inspectionDate, inspections in
                        Section(header: createHeaderView(getTitle(for: inspectionDate), subtitle: getSubtitle(for: inspectionDate))) {
                            VStack {
                                ForEach(inspections, id: \.self) { inspection in
                                    InspectionCard(inspection: inspection)
                                }
                            }
                            .padding(.top, 4) // 12 - spacing = 4
                        }
                        Spacer(minLength: 12)
                    }
                }
            }.onChange(of: searchQuery) { _ in
                viewModel.filterBasedOnSearch(searchText: searchQuery)
            }
        }
    }

    private func getTitle(for inspectionDate: Date) -> String {
        if Int(inspectionDate.formatToString(using: .yyyy)) == 1 {
            return "TODO: Mangler år"
        } else if viewModel.selectedInspectionStatus == .planned || viewModel.selectedInspectionStatus == .finalized {
            return inspectionDate.formatToString(using: .EEEEddMMMM).capitalized
        } else {
            return inspectionDate.formatToString(using: .yyyy).capitalized
        }
    }

    private func getSubtitle(for inspectionDate: Date) -> String? {
        if viewModel.selectedInspectionStatus == .planned {
            return Calendar.current.isDateInToday(inspectionDate)
                ? String(localized: "inspectionOverview.list.header.subtitle")
                : nil
        }
        return nil
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
