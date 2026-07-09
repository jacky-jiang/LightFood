import SwiftUI

/// Detailed calorie & nutrition breakdown for the current day.
struct CalorieDetailView: View {
    @EnvironmentObject private var diary: DiaryStore

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                ringCard
                macroCard
                waterCard
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 24)
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationTitle("今日热量详情")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var ringCard: some View {
        VStack(spacing: 20) {
            CalorieRing(progress: diary.progress, lineWidth: 14, gradient: LinearGradient(colors: [Theme.green], startPoint: .top, endPoint: .bottom)) {
                VStack(spacing: 0) {
                    Text("已摄入")
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.textMuted)
                    Text("\(diary.consumed)")
                        .font(.system(size: 38, weight: .heavy))
                        .foregroundStyle(Theme.textPrimary)
                    Text("kcal / 目标 \(diary.targetCalories)")
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.textMuted)
                }
            }
            .frame(width: 170, height: 170)

            HStack {
                VStack(spacing: 4) {
                    Text("\(diary.remaining)")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundStyle(Theme.orange)
                    Text("剩余 kcal")
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.textMuted)
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Rectangle().fill(Theme.divider).frame(width: 1, height: 34)
                }
                VStack(spacing: 4) {
                    Text(diary.progressText)
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundStyle(Theme.green)
                    Text("目标进度")
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.textMuted)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
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
                    carbs: diary.macroFractions.carbs
                ) {
                    Text("三大营养")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(Theme.textSlate)
                }
                .frame(width: 110, height: 110)

                VStack(spacing: 14) {
                    macroLegend(color: Theme.green, title: "蛋白质 \(percent(diary.macroFractions.protein))", value: "\(Int(diary.protein))g")
                    macroLegend(color: Theme.orange, title: "脂肪 \(percent(diary.macroFractions.fat))", value: "\(Int(diary.fat))g")
                    macroLegend(color: Theme.blue, title: "碳水 \(percent(diary.macroFractions.carbs))", value: "\(Int(diary.carbs))g")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(padding: 20)
    }

    private func macroLegend(color: Color, title: String, value: String) -> some View {
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

    private var waterCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("饮水提醒")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Theme.textPrimary)
                Spacer()
                Text("\(diary.waterMillilitres) / \(diary.waterTargetMillilitres) ml")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Theme.blue)
            }
            HStack(spacing: 8) {
                ForEach(0..<diary.waterGlassCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(index < diary.waterGlasses ? Theme.blue : Color(hex: 0xF3F9FE))
                        .frame(maxWidth: .infinity)
                        .frame(height: 34)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .strokeBorder(Color(hex: 0xDCEBF7), lineWidth: 1.5)
                        )
                }
                Button {
                    diary.addWater()
                } label: {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Theme.blueSoft)
                        .frame(width: 34, height: 34)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Theme.blue)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(padding: 20)
    }

    private func percent(_ fraction: Double) -> String {
        "\(Int((fraction * 100).rounded()))%"
    }
}

#Preview {
    NavigationStack {
        CalorieDetailView()
            .environmentObject(DiaryStore())
    }
}
