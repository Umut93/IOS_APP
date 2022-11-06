import SwiftUI

struct SegmentedLabel<Label, Badge>: View where Label: View, Badge: View {
    enum State {
        case enabled
        case selected
        case disabled
    }

    let state: State
    let label: () -> Label
    let badge: () -> Badge

    init(_ state: State, @ViewBuilder label: @escaping () -> Label, @ViewBuilder badge: @escaping () -> Badge) {
        self.state = state
        self.label = label
        self.badge = badge
    }

    var body: some View {
        ZStack {
            if state == .selected {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gradient, lineWidth: 1)
                    .background(Color.SystemGroupedBackgroundColor.tertiary)
            }

            HStack {
                label()
                    .frame(maxWidth: .infinity, alignment: .leading)
                badge()
            }
            .foregroundColor(.Label.primary)
            .padding(.all, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
        .contentShape(Rectangle())
    }
}
