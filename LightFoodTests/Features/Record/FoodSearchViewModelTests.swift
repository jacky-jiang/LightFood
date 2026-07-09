import XCTest
@testable import LightFood

@MainActor
final class FoodSearchViewModelTests: XCTestCase {
    func testStartsWithAllFoods() {
        let viewModel = FoodSearchViewModel()
        XCTAssertEqual(viewModel.results.count, FoodCatalog().foods().count)
    }

    func testQueryFiltersResults() {
        let viewModel = FoodSearchViewModel()
        viewModel.query = "鸡"
        XCTAssertEqual(viewModel.results.count, 2)
    }

    func testClearingQueryRestoresAll() {
        let viewModel = FoodSearchViewModel()
        viewModel.query = "鸡"
        viewModel.query = ""
        XCTAssertEqual(viewModel.results.count, FoodCatalog().foods().count)
    }
}
