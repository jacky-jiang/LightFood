import Foundation

/// A recommended recipe shown on the home and AI screens.
struct Recipe: Identifiable, Equatable, Hashable, Codable {
    let id: String
    let name: String
    let kcal: Int
    let tags: [String]
    let description: String
    let ingredients: [String]
    let protein: Int
    let fat: Int
    let carbs: Int
    let imageURL: URL?

    init(
        id: String = UUID().uuidString,
        name: String,
        kcal: Int,
        tags: [String],
        description: String,
        ingredients: [String],
        protein: Int,
        fat: Int,
        carbs: Int,
        imageURL: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.kcal = kcal
        self.tags = tags
        self.description = description
        self.ingredients = ingredients
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
        self.imageURL = imageURL
    }

    var primaryTag: String { tags.first ?? "推荐" }
}
