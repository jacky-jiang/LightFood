import XCTest
@testable import LightFood

final class FoodTests: XCTestCase {
    func testNutritionScalesWithPortion() {
        let food = Food(name: "鸡胸肉", kcalPer100g: 133, proteinPer100g: 22, fatPer100g: 1.5, carbsPer100g: 0)

        let half = food.nutrition(forGrams: 50)
        XCTAssertEqual(half.kcal, 67) // 66.5 rounded
        XCTAssertEqual(half.protein, 11, accuracy: 0.001)

        let double = food.nutrition(forGrams: 200)
        XCTAssertEqual(double.kcal, 266)
        XCTAssertEqual(double.fat, 3, accuracy: 0.001)
    }

    func testScaledNutritionFormatting() {
        let food = Food(name: "牛油果", kcalPer100g: 160, proteinPer100g: 2, fatPer100g: 15, carbsPer100g: 9)
        let nutrition = food.nutrition(forGrams: 100)
        XCTAssertEqual(nutrition.fatText, "15.0")
        XCTAssertEqual(nutrition.proteinText, "2.0")
    }

    func testPerServingDescription() {
        let food = Food(name: "香蕉", kcalPer100g: 93, proteinPer100g: 1.4, fatPer100g: 0.4, carbsPer100g: 28.8)
        XCTAssertEqual(food.perServingDescription, "93 kcal / 100g")
    }
}
