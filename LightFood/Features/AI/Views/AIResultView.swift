import SwiftUI

/// The generated AI nutrition plan.
struct AIResultView: View {
    @Binding var path: [AppRoute]
    @EnvironmentObject private var plan: AIPlanViewModel
    @EnvironmentObject private var tabRouter: TabRouter

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                summaryCard
                mealsCard
                confidenceCard
                actionButtons
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 24)
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationTitle("今日 AI 建议")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("今日建议热量")
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.9))
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text("\(plan.recommendedCalories)")
                    .font(.system(size: 40, weight: .heavy))
                Text("kcal")
                    .font(.system(size: 16))
            }
            .foregroundStyle(.white)
            .padding(.top, 6)
            Text(plan.recommendedRange)
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.9))
                .padding(.top, 4)
            HStack(spacing: 10) {
                macroPill(value: "78g", title: "蛋白质")
                macroPill(value: "142g", title: "碳水")
                macroPill(value: "42g", title: "脂肪")
            }
            .padding(.top, 18)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(22)
        .background(
            LinearGradient(colors: [Color(hex: 0x25C55E), Color(hex: 0x1FA84E)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Theme.green.opacity(0.28), radius: 13, y: 12)
    }

    private func macroPill(value: String, title: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 16, weight: .heavy))
            Text(title)
                .font(.system(size: 11))
                .opacity(0.9)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(.white.opacity(0.16))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var mealsCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("今日餐次建议")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
                .padding(.bottom, 6)
            ForEach(plan.recipes) { recipe in
                Button {
                    path.append(.recipeDetail(recipe))
                } label: {
                    HStack(spacing: 12) {
                        RemoteThumbnail(url: recipe.imageURL, size: 48)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(recipe.name)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Theme.textPrimary)
                            Text(recipe.description)
                                .font(.system(size: 12))
                                .foregroundStyle(Theme.textMuted)
                                .lineLimit(1)
                        }
                        Spacer()
                        Text("\(recipe.kcal)")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Theme.orange)
                    }
                    .padding(.vertical, 12)
                }
                .buttonStyle(.plain)
                .overlay(alignment: .bottom) {
                    if recipe.id != plan.recipes.last?.id {
                        Rectangle().fill(Theme.divider).frame(height: 1)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    private var confidenceCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                HStack(spacing: 8) {
                    Text("🛡️").font(.system(size: 15))
                    Text("AI 可信度")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Theme.textPrimary)
                }
                Spacer()
                Text("\(plan.confidence)%")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundStyle(Theme.green)
            }
            MiniProgressBar(progress: Double(plan.confidence) / 100, height: 6)
                .padding(.top, 12)
            Text("数据来源: 饮食记录、体重变化、目标设置 · 参考《中国营养学会膳食指南 2022》")
                .font(.system(size: 12))
                .foregroundStyle(Theme.textMuted)
                .lineSpacing(3)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button {
                path = [.aiGenerating]
            } label: {
                Text("重新生成")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Theme.green)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(hex: 0xF0FBF3))
                    .clipShape(Capsule())
                    .overlay(Capsule().strokeBorder(Color(hex: 0xC9EED6), lineWidth: 1.5))
            }
            .buttonStyle(.plain)

            Button {
                path.removeAll()
                tabRouter.selection = .home
            } label: {
                Text("应用方案")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Theme.primaryButton)
                    .clipShape(Capsule())
                    .shadow(color: Theme.green.opacity(0.28), radius: 10, y: 10)
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 4)
    }
}

#Preview {
    NavigationStack {
        AIResultView(path: .constant([]))
            .environmentObject(AIPlanViewModel())
            .environmentObject(TabRouter())
    }
}
