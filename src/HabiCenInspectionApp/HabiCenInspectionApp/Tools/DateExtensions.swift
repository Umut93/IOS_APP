import Foundation

extension Date {
    func formatToString(using formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
}
