import XCTest
@testable import LightFood

@MainActor
final class AppFlowViewModelTests: XCTestCase {
    func testDefaultGoalsSelected() {
        let flow = AppFlowViewModel()
        XCTAssertTrue(flow.isSelected(.loseFat))
        XCTAssertTrue(flow.isSelected(.controlSugar))
        XCTAssertTrue(flow.isSelected(.stayHealthy))
        XCTAssertFalse(flow.isSelected(.buildMuscle))
    }

    func testToggleGoalAddsAndRemoves() {
        let flow = AppFlowViewModel()
        flow.toggleGoal(.buildMuscle)
        XCTAssertTrue(flow.isSelected(.buildMuscle))
        flow.toggleGoal(.buildMuscle)
        XCTAssertFalse(flow.isSelected(.buildMuscle))
    }

    func testPhaseTransitions() {
        let flow = AppFlowViewModel()
        XCTAssertEqual(flow.phase, .splash)
        flow.beginOnboarding()
        XCTAssertEqual(flow.phase, .goal)
        flow.enterApp()
        XCTAssertEqual(flow.phase, .main)
    }

    func testStartSplashAdvancesToWelcome() async {
        let flow = AppFlowViewModel(splashDuration: 0)
        await flow.startSplash()
        XCTAssertEqual(flow.phase, .welcome)
    }
}
