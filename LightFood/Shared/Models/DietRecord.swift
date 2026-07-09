import Foundation

/// A single logged food entry in the user's diary.
struct DietRecord: Identifiable, Equatable, Codable {
    let id: String
    let meal: MealType
    let name: String
    let kcal: Int
    /// Human readable time label, e.g. "07:30" or "现在".
    let time: String
    let imageURL: URL?

    init(
        id: String = UUID().uuidString,
        meal: MealType,
        name: String,
        kcal: Int,
        time: String,
        imageURL: URL? = nil
    ) {
        self.id = id
        self.meal = meal
        self.name = name
        self.kcal = kcal
        self.time = time
        self.imageURL = imageURL
    }
}
