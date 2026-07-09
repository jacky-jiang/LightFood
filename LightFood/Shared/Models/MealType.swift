import Foundation

/// The meal slot a food record belongs to.
enum MealType: String, CaseIterable, Identifiable, Codable, Equatable {
    case breakfast
    case lunch
    case dinner
    case snack

    var id: String { rawValue }

    /// Localized display label (Simplified Chinese, matching the design).
    var label: String {
        switch self {
        case .breakfast: return "早餐"
        case .lunch: return "午餐"
        case .dinner: return "晚餐"
        case .snack: return "加餐"
        }
    }
}
