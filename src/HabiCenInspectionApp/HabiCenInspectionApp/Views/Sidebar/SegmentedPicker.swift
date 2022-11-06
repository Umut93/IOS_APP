import SwiftUI

struct SegmentedPicker<Values, Content>: View where Values: RandomAccessCollection, Values.Element: Hashable, Values.Index: Hashable, Content: View {
    @Binding var selection: Values.Element
    private let title: String
    private let selections: Values
    private let content: (Values.Element) -> Content

    init(_ title: String, selections: Values, selection: Binding<Values.Element>, @ViewBuilder content: @escaping (Values.Element) -> Content) {
        self.title = title
        self.selections = selections
        self._selection = selection
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(title)
                .font(Font.HabiCen.subheadlineBold)
                .foregroundColor(.Label.secondary)
                .padding(.bottom, 12)

            ForEach(selections.indices, id: \.self) { selectionIndex in
                let selection = selections[selectionIndex]

                content(selection)
                    .onTapGesture {
                        self.selection = selection
                    }
            }
        }
    }
}
