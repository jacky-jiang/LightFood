import Foundation

/// A selectable health goal shown during onboarding.
enum GoalOption: String, CaseIterable, Identifiable, Equatable {
    case loseFat
    case controlSugar
    case buildMuscle
    case stayHealthy
    case trackDiet

    var id: String { rawValue }

    var label: String {
        switch self {
        case .loseFat: return "减脂"
        case .controlSugar: return "控糖"
        case .buildMuscle: return "增肌"
        case .stayHealthy: return "保持健康"
        case .trackDiet: return "记录饮食"
        }
    }

    var subtitle: String {
        switch self {
        case .loseFat: return "减少体脂,塑造好身材"
        case .controlSugar: return "稳定血糖,维持健康水平"
        case .buildMuscle: return "增加肌肉,提升体能"
        case .stayHealthy: return "均衡营养,维持身体健康"
        case .trackDiet: return "记录每日饮食,了解自己"
        }
    }

    var emoji: String {
        switch self {
        case .loseFat: return "🔥"
        case .controlSugar: return "🩸"
        case .buildMuscle: return "💪"
        case .stayHealthy: return "🥗"
        case .trackDiet: return "📖"
        }
    }
}
