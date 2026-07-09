import SwiftUI

/// The home dashboard: calorie summary, quick actions, today's records and a
/// recommended recipe.
struct HomeView: View {
    @Binding var path: [AppRoute]
    @EnvironmentObject private var diary: DiaryStore
    @EnvironmentObject private var tabRouter: TabRouter
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                header
                calorieCard
                quickAddCard
                recordsCard
                if let recipe = viewModel.featuredRecipe {
                    recommendedCard(recipe)
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 26)
        }
        .background(Theme.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: Header

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.greeting)
                    .font(.system(size: 21, weight: .heavy))
                    .foregroundStyle(Theme.textPrimary)
                Text(viewModel.dateText)
                    .font(.system(size: 13))
                    .foregroundStyle(Theme.textMuted)
            }
            Spacer()
            Circle()
                .fill(.white)
                .frame(width: 38, height: 38)
                .overlay(
                    Image(systemName: "bell")
                        .font(.system(size: 16))
                        .foregroundStyle(Theme.textPrimary)
                )
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
        .padding(.top, 8)
        .padding(.horizontal, 4)
    }

    // MARK: Calorie card

    private var calorieCard: some View {
        Button {
            path.append(.calorieDetail)
        } label: {
            VStack(spacing: 18) {
                HStack(spacing: 20) {
                    CalorieRing(progress: diary.progress) {
                        VStack(spacing: 0) {
                            Text("已摄入")
                                .font(.system(size: 11))
                                .foregroundStyle(Theme.textMuted)
                            Text("\(diary.consumed)")
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundStyle(Theme.textPrimary)
                            Text("kcal")
                                .font(.system(size: 11))
                                .foregroundStyle(Theme.textMuted)
                        }
                    }
                    .frame(width: 120, height: 120)

                    VStack(spacing: 12) {
                        summaryRow(title: "目标", value: "\(diary.targetCalories) kcal")
                        Divider()
                        summaryRow(title: "剩余", value: "\(diary.remaining) kcal", valueColor: Theme.orange)
                        Divider()
                        summaryRow(title: "进度", value: diary.progressText, valueColor: Theme.green)
                    }
                }
                macroRow
            }
            .cardStyle(padding: 20)
        }
        .buttonStyle(.plain)
    }

    private func summaryRow(title: String, value: String, valueColor: Color = Theme.textPrimary) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(Theme.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(valueColor)
        }
    }

    private var macroRow: some View {
        HStack(spacing: 10) {
            MacroStatTile(label: "蛋白质", value: Int(diary.protein), target: Int(diary.proteinTarget), color: Theme.green)
            MacroStatTile(label: "脂肪", value: Int(diary.fat), target: Int(diary.fatTarget), color: Theme.orange)
            MacroStatTile(label: "碳水", value: Int(diary.carbs), target: Int(diary.carbsTarget), color: Theme.blue)
        }
    }

    // MARK: Quick add

    private var quickAddCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("快捷记录")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
            HStack {
                QuickAction(title: "拍照识别", systemImage: "camera", tint: Theme.green, background: Theme.greenSoft) {
                    path.append(.camera)
                }
                Spacer()
                QuickAction(title: "扫码录入", systemImage: "barcode.viewfinder", tint: Theme.orange, background: Theme.orangeSoft) {
                    path.append(.search)
                }
                Spacer()
                QuickAction(title: "手动添加", systemImage: "square.and.pencil", tint: Theme.blueAlt, background: Theme.blueSoft) {
                    path.append(.search)
                }
                Spacer()
                QuickAction(title: "历史记录", systemImage: "chart.bar", tint: Theme.amber, background: Theme.amberSoft) {
                    tabRouter.selection = .stats
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    // MARK: Records

    private var recordsCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeader(title: "今日饮食记录", trailingTitle: "更多 ›") {
                tabRouter.selection = .record
            }
            .padding(.bottom, 6)
            ForEach(Array(diary.records.prefix(3))) { record in
                DietRecordRow(record: record)
                    .overlay(alignment: .bottom) {
                        if record.id != diary.records.prefix(3).last?.id {
                            Rectangle().fill(Theme.divider).frame(height: 1)
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    // MARK: Recommended recipe

    private func recommendedCard(_ recipe: Recipe) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "推荐食谱", trailingTitle: "更多 ›") {
                tabRouter.selection = .ai
            }
            Button {
                path.append(.recipeDetail(recipe))
            } label: {
                HStack(spacing: 14) {
                    RemoteThumbnail(url: recipe.imageURL, size: 96, cornerRadius: 16)
                    VStack(alignment: .leading, spacing: 6) {
                        Text(recipe.name)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Theme.textPrimary)
                        Text(recipe.description)
                            .font(.system(size: 12))
                            .foregroundStyle(Theme.textMuted)
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                        HStack(spacing: 8) {
                            Text("推荐")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(Theme.green)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                                .background(Theme.greenSoft)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            Text("\(recipe.kcal) kcal")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Theme.orange)
                        }
                        .padding(.top, 4)
                    }
                    Spacer(minLength: 0)
                }
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

/// A quick-action tile (icon + label) used in the home quick-add card.
private struct QuickAction: View {
    let title: String
    let systemImage: String
    let tint: Color
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(background)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: systemImage)
                            .font(.system(size: 22))
                            .foregroundStyle(tint)
                    )
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.textSlate)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView(path: .constant([]))
        .environmentObject(DiaryStore())
        .environmentObject(TabRouter())
}
