import Foundation

/// Filters the food catalog for the search screen.
@MainActor
final class FoodSearchViewModel: ObservableObject {
    @Published var query: String = "" {
        didSet { updateResults() }
    }
    @Published private(set) var results: [Food]

    private let catalog: FoodCatalogProviding

    init(catalog: FoodCatalogProviding = FoodCatalog()) {
        self.catalog = catalog
        self.results = catalog.foods()
    }

    private func updateResults() {
        results = catalog.searchFoods(matching: query)
    }
}
