import Foundation
import SwiftUI

extension View {
    func shadowStyle(_ shadows: Shadows) -> some View {
        let color = Color(hex: "#333333")

        switch shadows {
        case .shadow100:
            return self
                .shadow(color: color.opacity(0.14), radius: 2, x: 0, y: 1)
                .shadow(color: color.opacity(0.04), radius: 16, x: 0, y: 1)
        case .shadow200:
            return self
                .shadow(color: color.opacity(0.10), radius: 4, x: 0, y: 2)
                .shadow(color: color.opacity(0.05), radius: 24, x: 0, y: 2)
        case .shadow300:
            return self
                .shadow(color: color.opacity(0.07), radius: 6, x: 0, y: 3)
                .shadow(color: color.opacity(0.06), radius: 32, x: 0, y: 3)
        case .shadow400:
            return self
                .shadow(color: color.opacity(0.05), radius: 8, x: 0, y: 4)
                .shadow(color: color.opacity(0.07), radius: 40, x: 0, y: 4)
        case .shadow500:
            return self
                .shadow(color: color.opacity(0.04), radius: 10, x: 0, y: 5)
                .shadow(color: color.opacity(0.08), radius: 48, x: 0, y: 5)
        }
    }
}

enum Shadows {
    case shadow100
    case shadow200
    case shadow300
    case shadow400
    case shadow500
}
