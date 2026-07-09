import SwiftUI

/// Food detail with portion editing, live nutrition and meal selection.
struct FoodDetailView: View {
    @StateObject private var viewModel: FoodDetailViewModel
    @Binding var path: [AppRoute]
    @EnvironmentObject private var diary: DiaryStore

    init(food: Food, path: Binding<[AppRoute]>) {
        _viewModel = StateObject(wrappedValue: FoodDetailViewModel(food: food))
        _path = path
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                headerCard
                portionCard
                nutritionCard
                mealCard
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 24)
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationTitle("食物详情与分量")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "确认添加 · \(viewModel.nutrition.kcal) kcal") {
                viewModel.save(into: diary)
                path.append(.recordSuccess)
            }
            .padding(.horizontal, 18)
            .padding(.top, 14)
            .padding(.bottom, 12)
            .background(Theme.background)
        }
    }

    private var headerCard: some View {
        HStack(spacing: 16) {
            RemoteThumbnail(url: viewModel.food.imageURL, size: 72, cornerRadius: 16)
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.food.name)
                    .font(.system(size: 19, weight: .heavy))
                    .foregroundStyle(Theme.textPrimary)
                Text(viewModel.food.perServingDescription)
                    .font(.system(size: 13))
                    .foregroundStyle(Theme.textMuted)
            }
            Spacer()
            Circle()
                .fill(Color(hex: 0xFFF6EC))
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: "star")
                        .font(.system(size: 16))
                        .foregroundStyle(Theme.amber)
                )
        }
        .cardStyle()
    }

    private var portionCard: some View {
        VStack(spacing: 0) {
            HStack {
                Text("分量编辑")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Theme.textPrimary)
                Spacer()
                Text("单位: 克 (g)")
                    .font(.system(size: 13))
                    .foregroundStyle(Theme.textMuted)
            }
            .padding(.bottom, 18)

            HStack(spacing: 22) {
                stepperButton(systemImage: "minus", tint: Theme.textSlate, background: Theme.chipBackground) {
                    viewModel.adjustPortion(by: -viewModel.step)
                }
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(viewModel.portion)")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundStyle(Theme.textPrimary)
                    Text("g")
                        .font(.system(size: 16))
                        .foregroundStyle(Theme.textMuted)
                }
                stepperButton(systemImage: "plus", tint: Theme.green, background: Theme.greenSoft) {
                    viewModel.adjustPortion(by: viewModel.step)
                }
            }

            Slider(
                value: Binding(
                    get: { Double(viewModel.portion) },
                    set: { viewModel.portion = Int($0) }
                ),
                in: Double(viewModel.minPortion)...Double(viewModel.maxPortion),
                step: Double(viewModel.step)
            )
            .tint(Theme.green)
            .padding(.top, 20)

            HStack {
                Text("10g")
                Spacer()
                Text("250g")
                Spacer()
                Text("500g")
            }
            .font(.system(size: 11))
            .foregroundStyle(Color(hex: 0xB4BAC2))
        }
        .cardStyle(padding: 20)
    }

    private func stepperButton(systemImage: String, tint: Color, background: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Circle()
                .fill(background)
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: systemImage)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(tint)
                )
        }
        .buttonStyle(.plain)
    }

    private var nutritionCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 6) {
                Text("营养成分")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Theme.textPrimary)
                Text("(随分量变化)")
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.textMuted)
            }
            .padding(.bottom, 16)

            nutritionRow(title: "热量", value: "\(viewModel.nutrition.kcal) kcal", valueColor: Theme.orange)
            Divider()
            nutritionRow(title: "蛋白质", value: "\(viewModel.nutrition.proteinText) g")
            Divider()
            nutritionRow(title: "脂肪", value: "\(viewModel.nutrition.fatText) g")
            Divider()
            nutritionRow(title: "碳水", value: "\(viewModel.nutrition.carbsText) g")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(padding: 20)
    }

    private func nutritionRow(title: String, value: String, valueColor: Color = Theme.textPrimary) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(Theme.textSlate)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(valueColor)
        }
        .padding(.vertical, 11)
    }

    private var mealCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("选择餐次")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
            HStack(spacing: 10) {
                ForEach(MealType.allCases) { meal in
                    mealChip(meal)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(padding: 20)
    }

    private func mealChip(_ meal: MealType) -> some View {
        let selected = viewModel.meal == meal
        return Button {
            viewModel.selectMeal(meal)
        } label: {
            Text(meal.label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(selected ? Theme.green : Color(hex: 0x4B5563))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(selected ? Theme.greenSoft : Theme.chipBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(selected ? Theme.green : Color(hex: 0xEDF0F2), lineWidth: 1.5)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        FoodDetailView(food: FoodCatalog().foods()[3], path: .constant([]))
            .environmentObject(DiaryStore())
    }
}
