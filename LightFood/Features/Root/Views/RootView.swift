import SwiftUI

/// Root container that switches between the splash, onboarding and main app.
struct RootView: View {
    @StateObject private var flow = AppFlowViewModel()
    @StateObject private var diary = DiaryStore()

    var body: some View {
        Group {
            switch flow.phase {
            case .splash:
                SplashView()
                    .task { await flow.startSplash() }
            case .welcome:
                WelcomeView(onStart: flow.beginOnboarding)
            case .goal:
                GoalView(flow: flow)
            case .main:
                MainTabView()
            }
        }
        .environmentObject(diary)
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.35), value: flow.phase)
    }
}

#Preview {
    RootView()
}
