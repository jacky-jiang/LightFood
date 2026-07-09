import XCTest
@testable import LightFood

@MainActor
final class FoodDetailViewModelTests: XCTestCase {
    private func makeFood() -> Food {
        Food(name: "鸡胸肉", kcalPer100g: 133, proteinPer100g: 22, fatPer100g: 1.5, carbsPer100g: 0)
    }

    func testDefaultPortionAndMeal() {
        let viewModel = FoodDetailViewModel(food: makeFood())
        XCTAssertEqual(viewModel.portion, 100)
        XCTAssertEqual(viewModel.meal, .breakfast)
        XCTAssertEqual(viewModel.nutrition.kcal, 133)
    }

    func testAdjustPortionClampsToRange() {
        let viewModel = FoodDetailViewModel(food: makeFood())
        viewModel.adjustPortion(by: 10)
        XCTAssertEqual(viewModel.portion, 110)

        for _ in 0..<100 { viewModel.adjustPortion(by: 10) }
        XCTAssertEqual(viewModel.portion, viewModel.maxPortion)

        for _ in 0..<100 { viewModel.adjustPortion(by: -10) }
        XCTAssertEqual(viewModel.portion, viewModel.minPortion)
    }

    func testSelectMeal() {
        let viewModel = FoodDetailViewModel(food: makeFood())
        viewModel.selectMeal(.dinner)
        XCTAssertEqual(viewModel.meal, .dinner)
    }

    func testSaveLogsScaledRecordIntoDiary() {
        let food = makeFood()
        let viewModel = FoodDetailViewModel(food: food, portion: 200, meal: .lunch)
        let store = DiaryStore()
        let before = store.consumed

        let saved = viewModel.save(into: store)

        XCTAssertEqual(saved.kcal, 266)
        XCTAssertEqual(saved.meal, .lunch)
        XCTAssertEqual(store.consumed, before + 266)
        XCTAssertEqual(store.records.first, saved)
    }
}
