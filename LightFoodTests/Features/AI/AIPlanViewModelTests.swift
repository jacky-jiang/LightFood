import XCTest
@testable import LightFood

@MainActor
final class AIPlanViewModelTests: XCTestCase {
    func testDefaults() {
        let viewModel = AIPlanViewModel()
        XCTAssertEqual(viewModel.selectedGoal, "减脂")
        XCTAssertEqual(viewModel.selectedTaste, "清淡")
        XCTAssertEqual(viewModel.progress, 0)
        XCTAssertEqual(viewModel.recipes.count, 4)
    }

    func testSelection() {
        let viewModel = AIPlanViewModel()
        viewModel.selectGoal("增肌")
        viewModel.selectTaste("酸辣")
        XCTAssertEqual(viewModel.selectedGoal, "增肌")
        XCTAssertEqual(viewModel.selectedTaste, "酸辣")
    }

    func testTickAdvancesAndCompletes() {
        let viewModel = AIPlanViewModel()
        var finished = false
        var guardCount = 0
        while !finished && guardCount < 1000 {
            finished = viewModel.tick()
            guardCount += 1
        }
        XCTAssertTrue(finished)
        XCTAssertEqual(viewModel.progress, 1, accuracy: 0.0001)
        XCTAssertEqual(viewModel.progressPercent, 100)
    }

    func testRunGenerationReachesCompletion() async {
        let viewModel = AIPlanViewModel()
        await viewModel.runGeneration(stepNanoseconds: 0)
        XCTAssertEqual(viewModel.progress, 1, accuracy: 0.0001)
    }
}
