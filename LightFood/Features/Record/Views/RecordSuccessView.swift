import SwiftUI

/// Confirmation screen shown after a food is logged.
struct RecordSuccessView: View {
    @Binding var path: [AppRoute]
    @EnvironmentObject private var diary: DiaryStore
    @EnvironmentObject private var tabRouter: TabRouter
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(Theme.brandMark)
                .frame(width: 88, height: 88)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white)
                )
                .shadow(color: Theme.green.opacity(0.35), radius: 14, y: 14)
                .scaleEffect(appeared ? 1 : 0.4)
                .opacity(appeared ? 1 : 0)
                .padding(.top, 60)

            Text("记录成功")
                .font(.system(size: 22, weight: .heavy))
                .foregroundStyle(Theme.textPrimary)
                .padding(.top, 22)

            if let saved = diary.lastSaved {
                HStack(spacing: 0) {
                    Text("已保存到 ")
                        .foregroundStyle(Theme.textMuted)
                    Text(saved.meal.label)
                        .foregroundStyle(Theme.green)
                        .fontWeight(.semibold)
                    Text(" · 共 \(saved.kcal) kcal")
                        .foregroundStyle(Theme.textMuted)
                }
                .font(.system(size: 14))
                .padding(.top, 10)
            }

            recentCard
                .padding(.top, 30)

            Spacer()

            PrimaryButton(title: "继续记录") {
                path.removeAll()
                tabRouter.selection = .record
            }
            .padding(.top, 20)

            Button {
                path.removeAll()
                tabRouter.selection = .home
            } label: {
                Text("返回首页")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Theme.textGrey)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
            .buttonStyle(.plain)
            .padding(.top, 6)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
        .background(Theme.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                appeared = true
            }
        }
    }

    private var recentCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("最近记录")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Theme.textSlate)
                .padding(.top, 14)
                .padding(.bottom, 4)
            ForEach(Array(diary.records.prefix(3))) { record in
                DietRecordRow(record: record, thumbnailSize: 40, showMealColor: false)
                    .overlay(alignment: .top) {
                        Rectangle().fill(Theme.divider).frame(height: 1)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 9, y: 4)
    }
}

#Preview {
    NavigationStack {
        RecordSuccessView(path: .constant([]))
            .environmentObject(DiaryStore())
            .environmentObject(TabRouter())
    }
}
