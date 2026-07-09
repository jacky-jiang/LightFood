import Foundation

/// A food item from the catalog. Nutrition values are expressed per 100g.
struct Food: Identifiable, Equatable, Hashable, Codable {
    let id: String
    let name: String
    /// Calories per 100g.
    let kcalPer100g: Int
    /// Protein grams per 100g.
    let proteinPer100g: Double
    /// Fat grams per 100g.
    let fatPer100g: Double
    /// Carbohydrate grams per 100g.
    let carbsPer100g: Double
    let imageURL: URL?

    init(
        id: String = UUID().uuidString,
        name: String,
        kcalPer100g: Int,
        proteinPer100g: Double,
        fatPer100g: Double,
        carbsPer100g: Double,
        imageURL: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.kcalPer100g = kcalPer100g
        self.proteinPer100g = proteinPer100g
        self.fatPer100g = fatPer100g
        self.carbsPer100g = carbsPer100g
        self.imageURL = imageURL
    }

    /// A short "per 100g" description used in list rows.
    var perServingDescription: String {
        "\(kcalPer100g) kcal / 100g"
    }

    /// Nutrition scaled to the given portion in grams.
    func nutrition(forGrams grams: Int) -> ScaledNutrition {
        let ratio = Double(grams) / 100.0
        return ScaledNutrition(
            kcal: Int((Double(kcalPer100g) * ratio).rounded()),
            protein: proteinPer100g * ratio,
            fat: fatPer100g * ratio,
            carbs: carbsPer100g * ratio
        )
    }
}

/// Nutrition values scaled to a specific portion size.
struct ScaledNutrition: Equatable {
    let kcal: Int
    let protein: Double
    let fat: Double
    let carbs: Double

    /// Grams formatted to a single decimal place (e.g. "22.0").
    func formatted(_ value: Double) -> String {
        String(format: "%.1f", value)
    }

    var proteinText: String { formatted(protein) }
    var fatText: String { formatted(fat) }
    var carbsText: String { formatted(carbs) }
}
