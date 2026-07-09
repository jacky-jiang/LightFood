import Foundation

/// Holds the AI plan preferences and generation progress across the AI flow.
@MainActor
final class AIPlanViewModel: ObservableObject {
    @Published var selectedGoal: String = "减脂"
    @Published var selectedTaste: String = "清淡"
    @Published private(set) var progress: Double = 0

    let goals = ["减脂", "控糖", "增肌", "健康饮食"]
    let tastes = ["清淡", "鲜香", "酸辣", "甜口"]

    let recommendedCalories = 1260
    let recommendedRange = "建议范围 1200 - 1400 kcal"
    let confidence = 92
    let recipes: [Recipe]

    private let progressStep = 0.03

    init(catalog: FoodCatalogProviding = FoodCatalog()) {
        self.recipes = catalog.recipes()
    }

    var progressPercent: Int { Int((progress * 100).rounded()) }

    func selectGoal(_ goal: String) { selectedGoal = goal }
    func selectTaste(_ taste: String) { selectedTaste = taste }

    func resetProgress() { progress = 0 }

    /// Advances generation progress by one step. Returns `true` once complete.
    @discardableResult
    func tick() -> Bool {
        progress = min(1, progress + progressStep)
        return progress >= 1
    }

    /// Runs the simulated generation loop to completion.
    func runGeneration(stepNanoseconds: UInt64 = 70_000_000) async {
        resetProgress()
        while !tick() {
            try? await Task.sleep(nanoseconds: stepNanoseconds)
        }
    }
}
