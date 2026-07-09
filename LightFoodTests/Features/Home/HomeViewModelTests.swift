import XCTest
@testable import LightFood

@MainActor
final class HomeViewModelTests: XCTestCase {
    func testLoadSuccessUpdatesState() async {
        let service = MockHomeService(
            result: .success([
                HomeItem(id: "1", title: "Example")
            ])
        )

        let viewModel = HomeViewModel(service: service)

        await viewModel.load()

        XCTAssertEqual(
            viewModel.state,
            .loaded([
                HomeItem(id: "1", title: "Example")
            ])
        )
    }

    func testLoadFailureUpdatesState() async {
        let service = MockHomeService(result: .failure(MockError.failed))
        let viewModel = HomeViewModel(service: service)

        await viewModel.load()

        if case .failed = viewModel.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected failed state")
        }
    }
}
