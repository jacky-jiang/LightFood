import Foundation

/// App-wide observable state for the user's daily food diary.
///
/// Shared across the Home, Record, Stats and AI features via the SwiftUI
/// environment so that logging a food anywhere updates every screen.
@MainActor
final class DiaryStore: ObservableObject {
    @Published private(set) var records: [DietRecord]
    @Published private(set) var consumed: Int
    @Published private(set) var protein: Double
    @Published private(set) var fat: Double
    @Published private(set) var carbs: Double
    @Published private(set) var waterGlasses: Int
    @Published var targetCalories: Int

    /// The most recently saved record, surfaced on the success screen.
    @Published private(set) var lastSaved: DietRecord?

    let proteinTarget: Double = 120
    let fatTarget: Double = 60
    let carbsTarget: Double = 220
    let waterGlassCount = 8
    let millilitresPerGlass = 250

    init(catalog: FoodCatalogProviding = FoodCatalog()) {
        self.consumed = 1260
        self.targetCalories = 1800
        self.protein = 78
        self.fat = 42
        self.carbs = 156
        self.waterGlasses = 4
        self.records = DiaryStore.seedRecords(catalog: catalog)
    }

    // MARK: Derived values

    var remaining: Int { max(0, targetCalories - consumed) }

    /// Intake as a fraction of the target, clamped to 0...1.
    var progress: Double {
        guard targetCalories > 0 else { return 0 }
        return min(1, Double(consumed) / Double(targetCalories))
    }

    var progressPercent: Int { Int((progress * 100).rounded()) }
    var progressText: String { "\(progressPercent)%" }

    var waterMillilitres: Int { waterGlasses * millilitresPerGlass }
    var waterTargetMillilitres: Int { waterGlassCount * millilitresPerGlass }

    /// Macronutrient fractions for the donut chart, normalised to sum to 1.
    var macroFractions: (protein: Double, fat: Double, carbs: Double) {
        let total = protein + fat + carbs
        guard total > 0 else { return (0, 0, 0) }
        return (protein / total, fat / total, carbs / total)
    }

    // MARK: Mutations

    /// Logs a food at the given portion and meal, returning the saved record.
    @discardableResult
    func addFood(_ food: Food, grams: Int, meal: MealType, time: String = "现在") -> DietRecord {
        let nutrition = food.nutrition(forGrams: grams)
        let record = DietRecord(
            meal: meal,
            name: food.name,
            kcal: nutrition.kcal,
            time: time,
            imageURL: food.imageURL
        )
        records.insert(record, at: 0)
        consumed += nutrition.kcal
        protein += nutrition.protein
        fat += nutrition.fat
        carbs += nutrition.carbs
        lastSaved = record
        return record
    }

    func addWater() {
        guard waterGlasses < waterGlassCount else { return }
        waterGlasses += 1
    }

    // MARK: Seed data

    private static func seedRecords(catalog: FoodCatalogProviding) -> [DietRecord] {
        let foods = Dictionary(uniqueKeysWithValues: catalog.foods().map { ($0.id, $0) })
        return [
            DietRecord(meal: .breakfast, name: "燕麦牛奶粥", kcal: 250, time: "07:30", imageURL: foods["oat"]?.imageURL),
            DietRecord(meal: .breakfast, name: "水煮蛋", kcal: 100, time: "07:35", imageURL: foods["egg"]?.imageURL),
            DietRecord(meal: .lunch, name: "鸡胸肉沙拉", kcal: 350, time: "12:30", imageURL: foods["chicken"]?.imageURL),
            DietRecord(meal: .lunch, name: "糙米饭", kcal: 100, time: "12:35", imageURL: foods["rice"]?.imageURL)
        ]
    }
}
