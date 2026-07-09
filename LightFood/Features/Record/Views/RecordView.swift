import SwiftUI

/// The Record tab: entry points for logging plus today's overview and recent
/// records.
struct RecordView: View {
    @Binding var path: [AppRoute]
    @EnvironmentObject private var diary: DiaryStore

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LazyVGrid(columns: columns, spacing: 14) {
                    RecordMethodCard(title: "拍照识别", subtitle: "智能识别食物热量", systemImage: "camera", tint: Theme.green, background: Theme.greenSoft) {
                        path.append(.camera)
                    }
                    RecordMethodCard(title: "扫码录入", subtitle: "扫描条形码快速录入", systemImage: "barcode.viewfinder", tint: Theme.orange, background: Theme.orangeSoft) {
                        path.append(.search)
                    }
                    RecordMethodCard(title: "手动输入", subtitle: "搜索食物并录入", systemImage: "square.and.pencil", tint: Theme.blueAlt, background: Theme.blueSoft) {
                        path.append(.search)
                    }
                    RecordMethodCard(title: "收藏食物", subtitle: "从收藏中快速选择", systemImage: "star", tint: Theme.amber, background: Theme.amberSoft) {
                        path.append(.search)
                    }
                }

                overviewCard

                VStack(alignment: .leading, spacing: 0) {
                    Text("最近添加")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Theme.textPrimary)
                        .padding(.horizontal, 4)
                        .padding(.bottom, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 0) {
                        ForEach(Array(diary.records.prefix(4))) { record in
                            DietRecordRow(record: record)
                            if record.id != diary.records.prefix(4).last?.id {
                                Rectangle().fill(Theme.divider).frame(height: 1)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .background(Theme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: .black.opacity(0.04), radius: 9, y: 4)
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 26)
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationTitle("记录饮食")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var overviewCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("今日概览")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
            HStack(spacing: 16) {
                CalorieRing(progress: diary.progress, lineWidth: 8) {
                    Text(diary.progressText)
                        .font(.system(size: 15, weight: .heavy))
                        .foregroundStyle(Theme.textPrimary)
                }
                .frame(width: 72, height: 72)

                VStack(spacing: 10) {
                    overviewRow(title: "已摄入", value: "\(diary.consumed) kcal")
                    overviewRow(title: "还可摄入", value: "\(diary.remaining) kcal", valueColor: Theme.orange)
                    overviewRow(title: "今日目标", value: "\(diary.targetCalories) kcal")
                }
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    private func overviewRow(title: String, value: String, valueColor: Color = Theme.textPrimary) -> some View {
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
}

/// A large record-method card in the 2-column grid.
private struct RecordMethodCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let tint: Color
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(background)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: systemImage)
                            .font(.system(size: 26))
                            .foregroundStyle(tint)
                    )
                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Theme.textPrimary)
                    Text(subtitle)
                        .font(.system(size: 11))
                        .foregroundStyle(Theme.textMuted)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 22)
            .background(Theme.card)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: .black.opacity(0.04), radius: 9, y: 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        RecordView(path: .constant([]))
            .environmentObject(DiaryStore())
    }
}
