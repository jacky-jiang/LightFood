import Foundation

/// Supplies the catalog of foods and recommended recipes.
///
/// Backed by static sample data today; a networked implementation could be
/// swapped in without touching the feature layer.
protocol FoodCatalogProviding {
    func foods() -> [Food]
    func recipes() -> [Recipe]

    /// Foods whose name contains `query` (case/diacritic tolerant). An empty
    /// query returns the full list.
    func searchFoods(matching query: String) -> [Food]
}

extension FoodCatalogProviding {
    func searchFoods(matching query: String) -> [Food] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return foods() }
        return foods().filter {
            $0.name.localizedCaseInsensitiveContains(trimmed)
        }
    }
}
