import XCTest
@testable import LightFood

@MainActor
final class HomeViewModelTests: XCTestCase {
    private func date(year: Int, month: Int, day: Int, hour: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        return Calendar(identifier: .gregorian).date(from: components)!
    }

    func testMorningGreeting() {
        let viewModel = HomeViewModel(now: date(year: 2026, month: 5, day: 20, hour: 8))
        XCTAssertEqual(viewModel.greeting, "早上好,今天也要加油哦!")
    }

    func testEveningGreeting() {
        let viewModel = HomeViewModel(now: date(year: 2026, month: 5, day: 20, hour: 21))
        XCTAssertTrue(viewModel.greeting.hasPrefix("晚上好"))
    }

    func testDateTextFormat() {
        let viewModel = HomeViewModel(now: date(year: 2026, month: 5, day: 20, hour: 8))
        XCTAssertTrue(viewModel.dateText.hasPrefix("5月20日"))
    }

    func testFeaturedRecipeIsFirst() {
        let viewModel = HomeViewModel(catalog: FoodCatalog())
        XCTAssertEqual(viewModel.featuredRecipe, FoodCatalog().recipes().first)
    }
}
