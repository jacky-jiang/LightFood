import SwiftUI

/// Searches the food catalog and opens the detail screen for a selection.
struct FoodSearchView: View {
    @Binding var path: [AppRoute]
    @StateObject private var viewModel = FoodSearchViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var searchFocused: Bool

    private let filters = ["全部", "食物", "菜品", "品牌"]
    @State private var selectedFilter = "全部"

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 15))
                        .foregroundStyle(Theme.textMuted)
                    TextField("搜索食物、菜品、品牌", text: $viewModel.query)
                        .font(.system(size: 14))
                        .focused($searchFocused)
                        .submitLabel(.search)
                }
                .padding(.horizontal, 12)
                .frame(height: 40)
                .background(Theme.card)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                Button("取消") { dismiss() }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Theme.green)
            }
            .padding(.horizontal, 18)
            .padding(.top, 8)
            .padding(.bottom, 12)

            HStack(spacing: 20) {
                ForEach(filters, id: \.self) { filter in
                    filterTab(filter)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.results) { food in
                        Button {
                            path.append(.foodDetail(food))
                        } label: {
                            searchRow(food)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
            }
        }
        .background(Theme.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .onAppear { searchFocused = true }
    }

    private func filterTab(_ filter: String) -> some View {
        let selected = filter == selectedFilter
        return Button {
            selectedFilter = filter
        } label: {
            VStack(spacing: 6) {
                Text(filter)
                    .font(.system(size: 14, weight: selected ? .bold : .regular))
                    .foregroundStyle(selected ? Theme.green : Theme.textMuted)
                Rectangle()
                    .fill(selected ? Theme.green : .clear)
                    .frame(height: 2)
            }
            .fixedSize()
        }
        .buttonStyle(.plain)
    }

    private func searchRow(_ food: Food) -> some View {
        HStack(spacing: 12) {
            RemoteThumbnail(url: food.imageURL, size: 46)
            VStack(alignment: .leading, spacing: 3) {
                Text(food.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Theme.textPrimary)
                Text(food.perServingDescription)
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.textMuted)
            }
            Spacer()
            Circle()
                .fill(Theme.greenSoft)
                .frame(width: 28, height: 28)
                .overlay(
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Theme.green)
                )
        }
        .padding(12)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.03), radius: 5, y: 2)
    }
}

#Preview {
    NavigationStack {
        FoodSearchView(path: .constant([]))
    }
}
