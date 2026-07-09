import SwiftUI

/// Navigation container for the AI tab. Owns the shared `AIPlanViewModel` so
/// preferences and results persist across the flow.
struct AITab: View {
    @State private var path: [AppRoute] = []
    @StateObject private var planViewModel = AIPlanViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            AIIntroView(path: $path)
                .appRouteDestinations(path: $path)
        }
        .environmentObject(planViewModel)
    }
}
