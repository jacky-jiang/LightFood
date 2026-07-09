import Foundation

/// Manages portion size and meal selection for a food before it is logged.
@MainActor
final class FoodDetailViewModel: ObservableObject {
    let food: Food

    @Published var portion: Int
    @Published var meal: MealType

    let minPortion = 10
    let maxPortion = 500
    let step = 10

    init(food: Food, portion: Int = 100, meal: MealType = .breakfast) {
        self.food = food
        self.portion = portion
        self.meal = meal
    }

    /// Nutrition scaled to the current portion.
    var nutrition: ScaledNutrition {
        food.nutrition(forGrams: portion)
    }

    /// Adjusts the portion by `delta` grams, clamped to the allowed range.
    func adjustPortion(by delta: Int) {
        portion = min(maxPortion, max(minPortion, portion + delta))
    }

    func selectMeal(_ meal: MealType) {
        self.meal = meal
    }

    /// Logs the food into the shared diary and returns the saved record.
    @discardableResult
    func save(into diary: DiaryStore) -> DietRecord {
        diary.addFood(food, grams: portion, meal: meal)
    }
}
