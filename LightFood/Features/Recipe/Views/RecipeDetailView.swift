import SwiftUI

/// Full recipe detail with macros and ingredient list.
struct RecipeDetailView: View {
    let recipe: Recipe
    @Binding var path: [AppRoute]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Color.clear
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .overlay { heroImage }
                    .clipped()

                VStack(alignment: .leading, spacing: 0) {
                    Text(recipe.name)
                        .font(.system(size: 23, weight: .heavy))
                        .foregroundStyle(Theme.textPrimary)

                    HStack(spacing: 8) {
                        Text(recipe.primaryTag)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Theme.green)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Theme.greenSoft)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        Text("\(recipe.kcal) kcal")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundStyle(Theme.orange)
                    }
                    .padding(.top, 12)

                    Text(recipe.description)
                        .font(.system(size: 14))
                        .foregroundStyle(Theme.textGrey)
                        .lineSpacing(6)
                        .padding(.top, 14)

                    HStack(spacing: 10) {
                        macroTile(value: "\(recipe.protein)g", title: "蛋白质", color: Theme.green)
                        macroTile(value: "\(recipe.fat)g", title: "脂肪", color: Theme.orange)
                        macroTile(value: "\(recipe.carbs)g", title: "碳水", color: Theme.blue)
                    }
                    .padding(.top, 18)

                    VStack(alignment: .leading, spacing: 0) {
                        Text("食材清单")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Theme.textPrimary)
                            .padding(.bottom, 12)
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack(spacing: 10) {
                                Circle().fill(Theme.green).frame(width: 6, height: 6)
                                Text(ingredient)
                                    .font(.system(size: 14))
                                    .foregroundStyle(Theme.textSlate)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(18)
                    .background(Theme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: .black.opacity(0.03), radius: 7, y: 3)
                    .padding(.top, 16)

                    PrimaryButton(title: "添加到今日饮食") {
                        path.append(.search)
                    }
                    .padding(.top, 22)
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                .padding(.bottom, 30)
                .background(Theme.background)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .offset(y: -24)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Theme.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private var heroImage: some View {
        AsyncImage(url: recipe.imageURL) { phase in
            if case .success(let image) = phase {
                image.resizable().scaledToFill()
            } else {
                ZStack {
                    Theme.greenSoft
                    Image(systemName: "fork.knife")
                        .font(.system(size: 44))
                        .foregroundStyle(Theme.green.opacity(0.5))
                }
            }
        }
    }

    private func macroTile(value: String, title: String, color: Color) -> some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.system(size: 18, weight: .heavy))
                .foregroundStyle(color)
            Text(title)
                .font(.system(size: 11))
                .foregroundStyle(Theme.textMuted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.03), radius: 6, y: 3)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: FoodCatalog().recipes()[0], path: .constant([]))
    }
}
