import SwiftUI

/// Onboarding goal picker (multi-select).
struct GoalView: View {
    @ObservedObject var flow: AppFlowViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ProgressCapsule(progress: 0.5)
                .padding(.top, 6)

            Text("你的主要目标是什么?")
                .font(.system(size: 24, weight: .heavy))
                .foregroundStyle(Theme.textPrimary)
                .padding(.top, 30)

            Text("可多选,帮你更精准推荐方案")
                .font(.system(size: 14))
                .foregroundStyle(Theme.textSecondary)
                .padding(.top, 10)

            VStack(spacing: 14) {
                ForEach(GoalOption.allCases) { goal in
                    GoalRow(
                        goal: goal,
                        isSelected: flow.isSelected(goal),
                        action: { flow.toggleGoal(goal) }
                    )
                }
            }
            .padding(.top, 26)

            Spacer()

            PrimaryButton(title: "下一步", action: flow.enterApp)
                .padding(.top, 20)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white.ignoresSafeArea())
    }
}

/// A single selectable goal card.
private struct GoalRow: View {
    let goal: GoalOption
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Text(goal.emoji)
                    .font(.system(size: 20))
                    .frame(width: 40, height: 40)
                    .background(isSelected ? Color(hex: 0xE1F5E8) : Theme.chipBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                VStack(alignment: .leading, spacing: 3) {
                    Text(goal.label)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Theme.textPrimary)
                    Text(goal.subtitle)
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.textMuted)
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(isSelected ? Theme.green : .white)
                        .overlay(
                            Circle().strokeBorder(
                                isSelected ? Theme.green : Color(hex: 0xD6DAE0),
                                lineWidth: 1.5
                            )
                        )
                        .frame(width: 22, height: 22)
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(16)
            .background(isSelected ? Color(hex: 0xF1FBF4) : .white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(isSelected ? Theme.green : Color(hex: 0xEDF0F2), lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}

/// A slim two-tone progress capsule used in onboarding headers.
struct ProgressCapsule: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Color(hex: 0xEDF0F2))
                Capsule()
                    .fill(Theme.green)
                    .frame(width: max(0, min(1, progress)) * geo.size.width)
            }
        }
        .frame(height: 4)
    }
}

#Preview {
    GoalView(flow: AppFlowViewModel())
}
