import SwiftUI

/// Navigation container for the Record tab.
struct RecordTab: View {
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            RecordView(path: $path)
                .appRouteDestinations(path: $path)
        }
    }
}
