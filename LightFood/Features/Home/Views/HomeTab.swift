import SwiftUI

/// Navigation container for the Home tab.
struct HomeTab: View {
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .appRouteDestinations(path: $path)
        }
    }
}
