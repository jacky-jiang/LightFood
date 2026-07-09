import SwiftUI

/// The Stats tab: daily summary, weekly trend and macro breakdown.
struct StatsView: View {
    @EnvironmentObject private var diary: DiaryStore
    @StateObject private var viewModel = StatsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    summaryCard
                    trendCard
                    macroCard
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 26)
            }
            .background(Theme.background.ignoresSafeArea())
            .safeAreaInset(edge: .top) {
                VStack(spacing: 4) {
                    Text("数据统计")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Theme.textPrimary)
                    Text(viewModel.dateText)
                        .font(.system(size: 13))
                        .foregroundStyle(Theme.textMuted)
                }
                .padding(.top, 10)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity)
                .background(Theme.background)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var summaryCard: some View {
        VStack(spacing: 18) {
            HStack(spacing: 20) {
                CalorieRing(progress: diary.progress, lineWidth: 11, gradient: LinearGradient(colors: [Theme.green], startPoint: .top, endPoint: .bottom)) {
                    VStack(spacing: 0) {
                        Text("总热量")
                            .font(.system(size: 11))
                            .foregroundStyle(Theme.textMuted)
                        Text("\(diary.consumed)")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundStyle(Theme.textPrimary)
                        Text("kcal")
                            .font(.system(size: 11))
                            .foregroundStyle(Theme.textMuted)
                    }
                }
                .frame(width: 110, height: 110)

                VStack(spacing: 12) {
                    summaryRow(title: "目标", value: "\(diary.targetCalories) kcal")
                    summaryRow(title: "达成率", value: diary.progressText, valueColor: Theme.green)
                    summaryRow(title: "状态", value: "良好", valueColor: Theme.orange)
                }
            }
            HStack(spacing: 10) {
                MacroStatTile(label: "蛋白质", value: Int(diary.protein), target: nil, color: Theme.green)
                MacroStatTile(label: "脂肪", value: Int(diary.fat), target: nil, color: Theme.orange)
                MacroStatTile(label: "碳水", value: Int(diary.carbs), target: nil, color: Theme.blue)
            }
        }
        .cardStyle(padding: 20)
    }

    private func summaryRow(title: String, value: String, valueColor: Color = Theme.textPrimary) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 13))
                .foregroundStyle(Theme.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(valueColor)
        }
    }

    private var trendCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("本周热量趋势")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Theme.textPrimary)
                Spacer()
                Text("平均 \(viewModel.weeklyAverage) kcal")
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.textMuted)
            }
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(viewModel.weeklyBars) { bar in
                    VStack(spacing: 8) {
                        Spacer(minLength: 0)
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(LinearGradient(colors: [Color(hex: 0x43C96C), Theme.green], startPoint: .top, endPoint: .bottom))
                            .frame(width: 22, height: max(6, bar.fraction * 100))
                        Text(bar.label)
                            .font(.system(size: 11))
                            .foregroundStyle(Theme.textMuted)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 120)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(padding: 20)
    }

    private var macroCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("营养占比")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
            HStack(spacing: 22) {
                MacroDonut(
                    protein: diary.macroFractions.protein,
                    fat: diary.macroFractions.fat,
                    carbs: diary.macroFractions.carbs,
                    thickness: 20
                ) {
                    VStack(spacing: 0) {
                        Text("\(diary.consumed)")
                            .font(.system(size: 18, weight: .heavy))
                            .foregroundStyle(Theme.textPrimary)
                        Text("kcal")
                            .font(.system(size: 10))
                            .foregroundStyle(Theme.textMuted)
                    }
                }
                .frame(width: 104, height: 104)

                VStack(spacing: 13) {
                    legendRow(color: Theme.blue, title: "碳水化合物", value: percent(diary.macroFractions.carbs))
                    legendRow(color: Theme.orange, title: "脂肪", value: percent(diary.macroFractions.fat))
                    legendRow(color: Theme.green, title: "蛋白质", value: percent(diary.macroFractions.protein))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(padding: 20)
    }

    private func legendRow(color: Color, title: String, value: String) -> some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 3).fill(color).frame(width: 10, height: 10)
            Text(title)
                .font(.system(size: 13))
                .foregroundStyle(Theme.textSlate)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
        }
    }

    private func percent(_ fraction: Double) -> String {
        "\(Int((fraction * 100).rounded()))%"
    }
}

#Preview {
    StatsView()
        .environmentObject(DiaryStore())
}
