import SwiftUI

/// Push destinations shared by the Home, Record and AI navigation stacks.
enum AppRoute: Hashable {
    case calorieDetail
    case camera
    case search
    case foodDetail(Food)
    case recordSuccess
    case recipeDetail(Recipe)
    case aiPreferences
    case aiGenerating
    case aiResult
}

/// Selectable bottom-bar tabs. Also used for cross-tab navigation.
enum AppTab: Hashable {
    case home
    case record
    case stats
    case ai
    case me
}

/// Holds the currently selected tab so screens can trigger cross-tab jumps
/// (e.g. Home's "更多 ›" links opening the Record tab).
@MainActor
final class TabRouter: ObservableObject {
    @Published var selection: AppTab = .home
}

extension View {
    /// Installs the shared destination mapping for `AppRoute` values onto a
    /// navigation stack, threading the `path` binding so screens can push and
    /// pop programmatically.
    func appRouteDestinations(path: Binding<[AppRoute]>) -> some View {
        navigationDestination(for: AppRoute.self) { route in
            AppRouteView(route: route, path: path)
        }
    }
}

/// Resolves an `AppRoute` to its destination screen.
struct AppRouteView: View {
    let route: AppRoute
    @Binding var path: [AppRoute]

    var body: some View {
        switch route {
        case .calorieDetail:
            CalorieDetailView()
        case .camera:
            CameraCaptureView(path: $path)
        case .search:
            FoodSearchView(path: $path)
        case .foodDetail(let food):
            FoodDetailView(food: food, path: $path)
        case .recordSuccess:
            RecordSuccessView(path: $path)
        case .recipeDetail(let recipe):
            RecipeDetailView(recipe: recipe, path: $path)
        case .aiPreferences:
            AIPreferencesView(path: $path)
        case .aiGenerating:
            AIGeneratingView(path: $path)
        case .aiResult:
            AIResultView(path: $path)
        }
    }
}
