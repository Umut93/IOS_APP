import SwiftUI

// Inspired by: https://stackoverflow.com/a/58606176

struct RoundedCorner: Shape {
    var corners: UIRectCorner = .allCorners
    var radius: CGFloat = .infinity

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ corners: UIRectCorner, _ radius: CGFloat) -> some View {
        clipShape(RoundedCorner(corners: corners, radius: radius))
    }
}
