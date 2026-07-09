import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case loaded([HomeItem])
        case failed(String)
    }

    @Published private(set) var state: State = .idle

    private let service: HomeServiceProtocol

    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }

    func load() async {
        state = .loading

        do {
            let items = try await service.fetchItems()
            state = .loaded(items)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
