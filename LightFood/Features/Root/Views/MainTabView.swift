import SwiftUI
import UIKit

/// The five-tab shell shown after onboarding.
struct MainTabView: View {
    @StateObject private var tabRouter = TabRouter()

    init() {
        // Match the design's flat, translucent tab bar.
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 1, alpha: 0.96)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $tabRouter.selection) {
            HomeTab()
                .tag(AppTab.home)
                .tabItem { Label("首页", systemImage: "house.fill") }

            RecordTab()
                .tag(AppTab.record)
                .tabItem { Label("记录", systemImage: "plus.app.fill") }

            StatsView()
                .tag(AppTab.stats)
                .tabItem { Label("统计", systemImage: "chart.bar.fill") }

            AITab()
                .tag(AppTab.ai)
                .tabItem { Label("AI", systemImage: "sparkles") }

            ProfileView()
                .tag(AppTab.me)
                .tabItem { Label("我的", systemImage: "person.fill") }
        }
        .tint(Theme.green)
        .environmentObject(tabRouter)
    }
}

#Preview {
    MainTabView()
        .environmentObject(DiaryStore())
}
