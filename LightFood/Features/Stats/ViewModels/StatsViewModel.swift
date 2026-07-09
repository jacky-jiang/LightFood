import Foundation

/// Supplies weekly trend data for the Stats screen.
@MainActor
final class StatsViewModel: ObservableObject {
    /// A single bar in the weekly calorie trend chart.
    struct DayBar: Identifiable {
        let id = UUID()
        let label: String
        /// Height fraction in the range 0...1.
        let fraction: Double
    }

    let weeklyBars: [DayBar] = [
        DayBar(label: "一", fraction: 0.62),
        DayBar(label: "二", fraction: 0.80),
        DayBar(label: "三", fraction: 0.54),
        DayBar(label: "四", fraction: 0.90),
        DayBar(label: "五", fraction: 0.70),
        DayBar(label: "六", fraction: 0.46),
        DayBar(label: "日", fraction: 0.66)
    ]

    let weeklyAverage = 1450

    /// A localized date label like "5月20日 星期一".
    let dateText: String

    init(calendar: Calendar = .current, now: Date = Date()) {
        let month = calendar.component(.month, from: now)
        let day = calendar.component(.day, from: now)
        let weekdayIndex = calendar.component(.weekday, from: now) - 1
        let weekdays = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        let weekday = weekdays.indices.contains(weekdayIndex) ? weekdays[weekdayIndex] : ""
        self.dateText = "\(month)月\(day)日 \(weekday)"
    }
}
