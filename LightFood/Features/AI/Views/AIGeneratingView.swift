import SwiftUI

/// Animated generation progress screen. On completion it replaces the stack
/// with the result screen.
struct AIGeneratingView: View {
    @Binding var path: [AppRoute]
    @EnvironmentObject private var plan: AIPlanViewModel
    @State private var spin = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .stroke(Color(hex: 0xEDF3EE), lineWidth: 12)
                Circle()
                    .trim(from: 0, to: plan.progress)
                    .stroke(Theme.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.2), value: plan.progress)
                VStack(spacing: 4) {
                    Text("\(plan.progressPercent)%")
                        .font(.system(size: 44, weight: .heavy))
                        .foregroundStyle(Theme.green)
                    Text("AI 分析中…")
                        .font(.system(size: 13))
                        .foregroundStyle(Theme.textMuted)
                }
            }
            .frame(width: 180, height: 180)
            .padding(.top, 60)

            VStack(spacing: 18) {
                completedStep("分析目标与偏好")
                completedStep("分析饮食记录")
                inProgressStep("生成营养建议")
            }
            .padding(.top, 40)

            Text("预计还需 20 秒,请稍候…")
                .font(.system(size: 13))
                .foregroundStyle(Theme.textFaint)
                .padding(.top, 30)

            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
        .frame(maxWidth: .infinity)
        .background(Color.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .onAppear { spin = true }
        .task {
            await plan.runGeneration()
            // Replace the pref+generating steps with the result screen.
            path = [.aiResult]
        }
    }

    private func completedStep(_ title: String) -> some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Theme.green)
                .frame(width: 24, height: 24)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                )
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(Theme.textSlate)
            Spacer()
            Text("完成")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Theme.green)
        }
    }

    private func inProgressStep(_ title: String) -> some View {
        HStack(spacing: 12) {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Theme.green, style: StrokeStyle(lineWidth: 2.5, lineCap: .round))
                .frame(width: 24, height: 24)
                .rotationEffect(.degrees(spin ? 360 : 0))
                .animation(.linear(duration: 0.8).repeatForever(autoreverses: false), value: spin)
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(Theme.textSlate)
            Spacer()
            Text("进行中")
                .font(.system(size: 13))
                .foregroundStyle(Theme.textMuted)
        }
    }
}

#Preview {
    NavigationStack {
        AIGeneratingView(path: .constant([]))
            .environmentObject(AIPlanViewModel())
    }
}
