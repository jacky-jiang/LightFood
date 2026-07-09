import SwiftUI

/// AI tab landing screen.
struct AIIntroView: View {
    @Binding var path: [AppRoute]

    var body: some View {
        VStack(spacing: 0) {
            Text("AI 营养建议")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
                .padding(.vertical, 10)

            Spacer(minLength: 0)

            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 34, style: .continuous)
                        .fill(LinearGradient(colors: [Color(hex: 0xE9FBEF), Color(hex: 0xD6F5E0)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Text("AI")
                                .font(.system(size: 34, weight: .heavy))
                                .tracking(1)
                                .foregroundStyle(Theme.green)
                        )
                        .shadow(color: Theme.green.opacity(0.14), radius: 16, y: 12)
                    Circle()
                        .fill(Theme.orange)
                        .frame(width: 26, height: 26)
                        .overlay(Text("✦").font(.system(size: 13)).foregroundStyle(.white))
                        .offset(x: 6, y: -6)
                }

                Text("AI 帮你定制\n专属饮食方案")
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundStyle(Theme.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.top, 24)

                Text("根据你的目标、饮食记录与偏好,\n生成个性化建议与一周轻食计划。")
                    .font(.system(size: 14))
                    .foregroundStyle(Theme.textGrey)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.top, 14)
            }

            HStack(spacing: 10) {
                featureTile(emoji: "🎯", title: "个性化")
                featureTile(emoji: "🔬", title: "科学分析")
                featureTile(emoji: "♻️", title: "持续优化")
            }
            .padding(.top, 30)

            Spacer(minLength: 0)

            PrimaryButton(title: "开始定制方案") {
                path.append(.aiPreferences)
            }
            .padding(.top, 26)

            Text("已为 12,368 位用户生成个性化方案")
                .font(.system(size: 12))
                .foregroundStyle(Theme.textFaint)
                .padding(.top, 14)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 26)
        .background(
            LinearGradient(colors: [Color(hex: 0xF1FBF3), Theme.background], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .toolbar(.hidden, for: .navigationBar)
    }

    private func featureTile(emoji: String, title: String) -> some View {
        VStack(spacing: 8) {
            Text(emoji).font(.system(size: 22))
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Theme.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 7, y: 3)
    }
}

#Preview {
    NavigationStack {
        AIIntroView(path: .constant([]))
            .environmentObject(AIPlanViewModel())
    }
}
