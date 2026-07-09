import XCTest
@testable import LightFood

final class FoodCatalogTests: XCTestCase {
    func testCatalogHasContent() {
        let catalog = FoodCatalog()
        XCTAssertEqual(catalog.foods().count, 8)
        XCTAssertEqual(catalog.recipes().count, 4)
    }

    func testSearchFiltersByName() {
        let catalog = FoodCatalog()
        let results = catalog.searchFoods(matching: "鸡")
        XCTAssertEqual(results.count, 2) // 鸡胸肉, 鸡蛋
        XCTAssertTrue(results.allSatisfy { $0.name.contains("鸡") })
    }

    func testEmptyQueryReturnsAll() {
        let catalog = FoodCatalog()
        XCTAssertEqual(catalog.searchFoods(matching: "   ").count, catalog.foods().count)
    }

    func testNoMatchReturnsEmpty() {
        let catalog = FoodCatalog()
        XCTAssertTrue(catalog.searchFoods(matching: "披萨").isEmpty)
    }
}
