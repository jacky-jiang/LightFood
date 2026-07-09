import SwiftUI

/// Launch screen with the animated brand mark.
struct SplashView: View {
    @State private var appeared = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: 0xE9FBEF), Color(hex: 0xF4FBF3), .white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Theme.brandMark)
                    .frame(width: 104, height: 104)
                    .overlay(
                        Circle()
                            .fill(.white)
                            .frame(width: 74, height: 74)
                            .overlay(
                                Image(systemName: "leaf.fill")
                                    .font(.system(size: 34))
                                    .foregroundStyle(Theme.brandMark)
                            )
                    )
                    .shadow(color: Theme.green.opacity(0.4), radius: 18, x: 0, y: 18)
                    .scaleEffect(appeared ? 1 : 0.4)
                    .opacity(appeared ? 1 : 0)

                Text("轻卡记")
                    .font(.system(size: 30, weight: .heavy))
                    .tracking(2)
                    .foregroundStyle(Color(hex: 0x1F2937))
                    .padding(.top, 26)

                Text("轻松记录每一餐,健康每一天")
                    .font(.system(size: 14))
                    .foregroundStyle(Theme.textGrey)
                    .padding(.top, 10)
            }

            VStack {
                Spacer()
                Text("健康生活 · 从每一餐开始")
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.textFaint)
                    .padding(.bottom, 54)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.6)) {
                appeared = true
            }
        }
    }
}

#Preview {
    SplashView()
}
