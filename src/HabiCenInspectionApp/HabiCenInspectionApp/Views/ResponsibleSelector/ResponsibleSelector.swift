import SwiftUI
struct ResponsibleSelector: View {
    @Binding var selections: [Responsible]
    @Binding var isResponsiblesSearchFieldFocused: Bool
    @State var searchText: String = ""
    @StateObject var viewModel: ResponsibleViewModel
    @FocusState private var isFocused: Bool
    init(selections: Binding<[Responsible]>, isResponsiblesSearchFieldFocused: Binding<Bool>) {
        _selections = selections
        _isResponsiblesSearchFieldFocused = isResponsiblesSearchFieldFocused
        _viewModel = StateObject(wrappedValue: .init(selections: selections))
    }

    var body: some View {
        HStack {
            Text("responsibleSelector.header")
                .lineLimit(1)
                .truncationMode(.tail)
                .font(.HabiCen.subheadlineBold)
                .foregroundColor(.Label.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button("responsibleSelector.button") {
                searchText = String()
                viewModel.resetResponsibleSelections()
            }
            .font(.HabiCen.subheadline)
            .foregroundColor(Color.accent)
            .frame(alignment: .trailing)
        }

        SearchField(searchText: $searchText, placeholder: String(localized: "responsibleSelector.searchField"))
            .focused($isFocused)
            .onChange(of: isFocused) { _ in
                isResponsiblesSearchFieldFocused.toggle()
            }
        LazyVStack {
            ResponsibleSelectorRow(person: viewModel.user, isSelected: self.selections.contains(viewModel.user!)) {
                if self.selections.contains(viewModel.user!) {
                    self.selections.removeAll(where: { $0 == viewModel.user! })
                } else {
                    self.selections.append(viewModel.user!)
                }
            }
            ResponsibleSelectorRow(
                text: String(localized: "responsibleSelector.others"),
                isSelected: viewModel.responsibles.filter { $0 != viewModel.user }.allSatisfy(self.selections.filter { $0 != viewModel.user }.contains)
            ) {
                if viewModel.responsibles.filter({ $0 != viewModel.user }).allSatisfy(self.selections.filter { $0 != viewModel.user }.contains) {
                    self.selections.removeAll(where: { $0 != viewModel.user })
                } else {
                    self.selections.append(contentsOf: viewModel.responsibles.filter { $0 != viewModel.user })
                }
            }
            ForEach(searchText.isEmpty ? viewModel.responsibles : viewModel.responsibles.filter { $0.name.lowercased().contains(searchText.lowercased()) }, id: \.self) { item in
                if item != viewModel.user {
                    ResponsibleSelectorRow(person: item, isSelected: self.selections.contains(item)) {
                        if self.selections.contains(item) {
                            self.selections.removeAll(where: { $0 == item })
                        } else {
                            self.selections.append(item)
                        }
                    }
                    .padding(.leading, 15)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear(perform: viewModel.doInitialLoad)
    }
}

struct ResponsibleSelectorRow: View {
    var person: Responsible?
    var text: String = ""
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            HStack {
                if isSelected {
                    Text(person?.name ?? text)
                        .font(.HabiCen.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "checkmark")
                        .frame(alignment: .trailing)
                } else {
                    Text(person?.name ?? text)
                        .font(.HabiCen.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.SystemGroupedBackgroundColor.primary)
        }
        .foregroundColor(.Label.primary)
        Divider()
            .padding(.leading, -15)
    }
}
