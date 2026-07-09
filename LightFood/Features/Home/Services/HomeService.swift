struct HomeService: HomeServiceProtocol {
    func fetchItems() async throws -> [HomeItem] {
        [
            HomeItem(id: "1", title: "Welcome to create-ai-ios-app"),
            HomeItem(id: "2", title: "Start building your native iOS app")
        ]
    }
}
