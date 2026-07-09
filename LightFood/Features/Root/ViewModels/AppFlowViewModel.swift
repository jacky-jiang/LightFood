import Foundation

/// Drives the top-level app flow: splash → onboarding → main tabs.
@MainActor
final class AppFlowViewModel: ObservableObject {
    enum Phase: Equatable {
        case splash
        case welcome
        case goal
        case main
    }

    @Published private(set) var phase: Phase = .splash

    /// Goals selected during onboarding. Seeded with the design defaults.
    @Published var selectedGoals: Set<GoalOption> = [.loseFat, .controlSugar, .stayHealthy]

    private let splashDuration: UInt64

    /// - Parameter splashDuration: nanoseconds to display the splash screen.
    init(splashDuration: UInt64 = 1_700_000_000) {
        self.splashDuration = splashDuration
    }

    /// Advances from the splash screen after a short delay.
    func startSplash() async {
        try? await Task.sleep(nanoseconds: splashDuration)
        if phase == .splash {
            phase = .welcome
        }
    }

    func beginOnboarding() {
        phase = .goal
    }

    func toggleGoal(_ goal: GoalOption) {
        if selectedGoals.contains(goal) {
            selectedGoals.remove(goal)
        } else {
            selectedGoals.insert(goal)
        }
    }

    func isSelected(_ goal: GoalOption) -> Bool {
        selectedGoals.contains(goal)
    }

    func enterApp() {
        phase = .main
    }
}
