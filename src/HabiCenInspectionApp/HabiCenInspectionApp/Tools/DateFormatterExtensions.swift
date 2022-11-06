import Foundation

extension DateFormatter {
    static let yyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.setLocalizedDateFormatFromTemplate("yyyy")
        return formatter
    }()

    static let EEEEddMMMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.setLocalizedDateFormatFromTemplate("EEEE, dd. MMMM")
        return formatter
    }()

    static let HHmm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        return formatter
    }()

    static let ddMMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.setLocalizedDateFormatFromTemplate("dd. MMM")
        return formatter
    }()
}
