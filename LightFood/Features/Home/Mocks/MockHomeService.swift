enum MockError: Error {
    case failed
}

struct MockHomeService: HomeServiceProtocol {
    let result: Result<[HomeItem], Error>

    func fetchItems() async throws -> [HomeItem] {
        try result.get()
    }
}
