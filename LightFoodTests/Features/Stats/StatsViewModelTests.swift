import XCTest
@testable import LightFood

@MainActor
final class StatsViewModelTests: XCTestCase {
    func testWeeklyBarsCoverSevenDays() {
        let viewModel = StatsViewModel()
        XCTAssertEqual(viewModel.weeklyBars.count, 7)
        XCTAssertTrue(viewModel.weeklyBars.allSatisfy { $0.fraction >= 0 && $0.fraction <= 1 })
    }

    func testDateTextFormat() {
        var components = DateComponents()
        components.year = 2026
        components.month = 5
        components.day = 20
        let date = Calendar(identifier: .gregorian).date(from: components)!
        let viewModel = StatsViewModel(now: date)
        XCTAssertTrue(viewModel.dateText.hasPrefix("5月20日"))
        XCTAssertTrue(viewModel.dateText.contains("星期"))
    }
}
