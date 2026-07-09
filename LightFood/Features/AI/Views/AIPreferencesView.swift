import SwiftUI

/// Collects goal and taste preferences before generating a plan.
struct AIPreferencesView: View {
    @Binding var path: [AppRoute]
    @EnvironmentObject private var plan: AIPlanViewModel

    private let goalColumns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("你的主要目标")
                        .sectionTitle()
                        .padding(.top, 12)

                    LazyVGrid(columns: goalColumns, spacing: 12) {
                        ForEach(plan.goals, id: \.self) { goal in
                            selectableTile(
                                title: goal,
                                selected: plan.selectedGoal == goal,
                                action: { plan.selectGoal(goal) }
                            )
                        }
                    }
                    .padding(.top, 14)

                    Text("口味偏好")
                        .sectionTitle()
                        .padding(.top, 26)

                    FlowChips(items: plan.tastes, selected: plan.selectedTaste) { taste in
                        plan.selectTaste(taste)
                    }
                    .padding(.top, 14)

                    HStack(spacing: 6) {
                        Text("其他备注")
                            .sectionTitle()
                        Text("(选填)")
                            .font(.system(size: 12))
                            .foregroundStyle(Theme.textMuted)
                    }
                    .padding(.top, 26)

                    Text("请输入其他忌口或注意事项…")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: 0xB4BAC2))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(14)
                        .background(Theme.background)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .padding(.top, 14)
                }
            }

            PrimaryButton(title: "生成方案") {
                path.append(.aiGenerating)
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 30)
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("目标与偏好")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func selectableTile(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(selected ? Theme.green : Color(hex: 0x4B5563))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(selected ? Theme.greenSoft : Theme.background)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(selected ? Theme.green : Color(hex: 0xEDF0F2), lineWidth: 1.5)
                )
        }
        .buttonStyle(.plain)
    }
}

/// A simple wrapping row of selectable chips.
private struct FlowChips: View {
    let items: [String]
    let selected: String
    let onSelect: (String) -> Void

    var body: some View {
        HStack(spacing: 12) {
            ForEach(items, id: \.self) { item in
                let isSelected = item == selected
                Button {
                    onSelect(item)
                } label: {
                    Text(item)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(isSelected ? Theme.green : Color(hex: 0x4B5563))
                        .padding(.horizontal, 22)
                        .padding(.vertical, 11)
                        .background(isSelected ? Theme.greenSoft : Theme.background)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(isSelected ? Theme.green : Color(hex: 0xEDF0F2), lineWidth: 1.5)
                        )
                }
                .buttonStyle(.plain)
            }
            Spacer(minLength: 0)
        }
    }
}

private extension View {
    func sectionTitle() -> some View {
        font(.system(size: 15, weight: .bold))
            .foregroundStyle(Theme.textPrimary)
    }
}

#Preview {
    NavigationStack {
        AIPreferencesView(path: .constant([]))
            .environmentObject(AIPlanViewModel())
    }
}
