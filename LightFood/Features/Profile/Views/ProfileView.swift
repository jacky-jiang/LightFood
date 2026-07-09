import SwiftUI

/// The "我的" (profile) tab.
struct ProfileView: View {
    private let menuItems: [MenuItem] = [
        MenuItem(emoji: "🎯", title: "我的目标", value: "健康减重", background: Theme.greenSoft),
        MenuItem(emoji: "📊", title: "数据概览", value: "", background: Theme.blueSoft),
        MenuItem(emoji: "⭐", title: "收藏食谱/食物", value: "56", background: Color(hex: 0xFFF3E2)),
        MenuItem(emoji: "🍽️", title: "饮食偏好", value: "清淡", background: Color(hex: 0xF0F3E8)),
        MenuItem(emoji: "⚙️", title: "设置与安全", value: "", background: Color(hex: 0xF0EEFB)),
        MenuItem(emoji: "💬", title: "帮助与反馈", value: "", background: Color(hex: 0xFDECEC))
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                header
                profileCard
                membershipCard
                statsRow
                menuCard
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 26)
        }
        .background(Theme.background.ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            Text("我的")
                .font(.system(size: 21, weight: .heavy))
                .foregroundStyle(Theme.textPrimary)
            Spacer()
            Image(systemName: "gearshape")
                .font(.system(size: 20))
                .foregroundStyle(Theme.textSlate)
        }
        .padding(.top, 8)
        .padding(.horizontal, 4)
    }

    private var profileCard: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(Theme.brandMark)
                .frame(width: 60, height: 60)
                .overlay(
                    Text("轻")
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundStyle(.white)
                )
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text("小轻卡")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundStyle(Theme.textPrimary)
                    Text("Lv.5")
                        .font(.system(size: 11))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color(hex: 0x333333))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                Text("坚持记录第 128 天")
                    .font(.system(size: 13))
                    .foregroundStyle(Theme.textMuted)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color(hex: 0xC4C9D0))
        }
        .cardStyle(padding: 20)
    }

    private var membershipCard: some View {
        HStack(spacing: 12) {
            Text("👑").font(.system(size: 20))
            VStack(alignment: .leading, spacing: 2) {
                Text("轻卡会员")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color(hex: 0x8A5A18))
                Text("会员有效期至 2025.06.20")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: 0xB08A54))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color(hex: 0xC9A96E))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            LinearGradient(colors: [Color(hex: 0xFFF3E2), Color(hex: 0xFFEBD2)], startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var statsRow: some View {
        HStack(spacing: 10) {
            statTile(value: "12", title: "连续打卡", color: Theme.green)
            statTile(value: "56", title: "收藏数量", color: Theme.orange)
            statTile(value: "78%", title: "本周达标", color: Theme.blue)
        }
    }

    private func statTile(value: String, title: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 22, weight: .heavy))
                .foregroundStyle(color)
            Text(title)
                .font(.system(size: 11))
                .foregroundStyle(Theme.textMuted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 7, y: 3)
    }

    private var menuCard: some View {
        VStack(spacing: 0) {
            ForEach(menuItems) { item in
                HStack(spacing: 14) {
                    Text(item.emoji)
                        .font(.system(size: 16))
                        .frame(width: 34, height: 34)
                        .background(item.background)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    Text(item.title)
                        .font(.system(size: 15))
                        .foregroundStyle(Theme.textPrimary)
                    Spacer()
                    if !item.value.isEmpty {
                        Text(item.value)
                            .font(.system(size: 13))
                            .foregroundStyle(Color(hex: 0xB4BAC2))
                    }
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color(hex: 0xC4C9D0))
                }
                .padding(.vertical, 15)
                if item.id != menuItems.last?.id {
                    Rectangle().fill(Theme.divider).frame(height: 1)
                }
            }
        }
        .padding(.horizontal, 18)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 9, y: 4)
    }
}

private struct MenuItem: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let value: String
    let background: Color
}

#Preview {
    ProfileView()
}
