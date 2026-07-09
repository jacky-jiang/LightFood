import Foundation

/// Provides catalog-derived content for the home dashboard (the diary state
/// itself lives in the shared `DiaryStore`).
@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe]

    private let catalog: FoodCatalogProviding
    private let calendar: Calendar
    private let now: Date

    init(
        catalog: FoodCatalogProviding = FoodCatalog(),
        calendar: Calendar = .current,
        now: Date = Date()
    ) {
        self.catalog = catalog
        self.calendar = calendar
        self.now = now
        self.recipes = catalog.recipes()
    }

    /// The first recommended recipe, shown on the dashboard.
    var featuredRecipe: Recipe? { recipes.first }

    /// A time-of-day greeting, e.g. "早上好,今天也要加油哦!".
    var greeting: String {
        let hour = calendar.component(.hour, from: now)
        let prefix: String
        switch hour {
        case 5..<11: prefix = "早上好"
        case 11..<14: prefix = "中午好"
        case 14..<18: prefix = "下午好"
        default: prefix = "晚上好"
        }
        return "\(prefix),今天也要加油哦!"
    }

    /// A localized date label like "5月20日 周一".
    var dateText: String {
        let month = calendar.component(.month, from: now)
        let day = calendar.component(.day, from: now)
        let weekdayIndex = calendar.component(.weekday, from: now) - 1
        let weekdays = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        let weekday = weekdays[safe: weekdayIndex] ?? ""
        return "\(month)月\(day)日 \(weekday)"
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
