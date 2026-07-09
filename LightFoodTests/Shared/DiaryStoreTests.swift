import XCTest
@testable import LightFood

@MainActor
final class DiaryStoreTests: XCTestCase {
    func testInitialDerivedValues() {
        let store = DiaryStore()
        XCTAssertEqual(store.consumed, 1260)
        XCTAssertEqual(store.targetCalories, 1800)
        XCTAssertEqual(store.remaining, 540)
        XCTAssertEqual(store.progressPercent, 70)
        XCTAssertEqual(store.progressText, "70%")
        XCTAssertEqual(store.records.count, 4)
    }

    func testAddFoodUpdatesTotalsAndInsertsAtFront() {
        let store = DiaryStore()
        let food = Food(name: "测试", kcalPer100g: 100, proteinPer100g: 10, fatPer100g: 5, carbsPer100g: 20)

        let saved = store.addFood(food, grams: 200, meal: .dinner)

        XCTAssertEqual(saved.kcal, 200)
        XCTAssertEqual(saved.meal, .dinner)
        XCTAssertEqual(store.consumed, 1460)
        XCTAssertEqual(store.remaining, 340)
        XCTAssertEqual(store.records.first, saved)
        XCTAssertEqual(store.records.count, 5)
        XCTAssertEqual(store.lastSaved, saved)
        XCTAssertEqual(store.protein, 78 + 20, accuracy: 0.001)
    }

    func testProgressClampsAtOne() {
        let store = DiaryStore()
        let food = Food(name: "大餐", kcalPer100g: 1000, proteinPer100g: 0, fatPer100g: 0, carbsPer100g: 0)
        store.addFood(food, grams: 500, meal: .lunch) // +5000 kcal

        XCTAssertEqual(store.progress, 1, accuracy: 0.0001)
        XCTAssertEqual(store.progressPercent, 100)
        XCTAssertEqual(store.remaining, 0)
    }

    func testAddWaterIncrementsAndCaps() {
        let store = DiaryStore()
        XCTAssertEqual(store.waterGlasses, 4)
        store.addWater()
        XCTAssertEqual(store.waterGlasses, 5)
        for _ in 0..<10 { store.addWater() }
        XCTAssertEqual(store.waterGlasses, store.waterGlassCount)
    }

    func testMacroFractionsSumToOne() {
        let store = DiaryStore()
        let fractions = store.macroFractions
        XCTAssertEqual(fractions.protein + fractions.fat + fractions.carbs, 1, accuracy: 0.0001)
    }
}
