protocol HomeServiceProtocol {
    func fetchItems() async throws -> [HomeItem]
}
