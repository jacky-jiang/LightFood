import SwiftUI

/// First onboarding screen introducing the app.
struct WelcomeView: View {
    let onStart: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 10) {
                BrandMark()
                Text("轻卡记")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Theme.textPrimary)
            }
            .padding(.top, 8)

            heroImage
                .frame(maxWidth: .infinity)
                .frame(height: 288)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .shadow(color: Theme.green.opacity(0.14), radius: 20, x: 0, y: 16)
                .padding(.top, 30)

            Text("欢迎使用轻卡记")
                .font(.system(size: 27, weight: .heavy))
                .foregroundStyle(Theme.textPrimary)
                .padding(.top, 30)

            Text("记录饮食,养成健康好习惯。\n拍照识别、AI 定制、数据分析,一站搞定。")
                .font(.system(size: 15))
                .foregroundStyle(Theme.textGrey)
                .lineSpacing(6)
                .padding(.top, 12)

            Spacer()

            PrimaryButton(title: "开始体验", action: onStart)

            HStack(spacing: 4) {
                Text("已有账号?")
                    .foregroundStyle(Theme.textFaint)
                Text("登录")
                    .foregroundStyle(Theme.green)
                    .fontWeight(.semibold)
            }
            .font(.system(size: 13))
            .frame(maxWidth: .infinity)
            .padding(.top, 18)
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 34)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(
                colors: [Color(hex: 0xF1FBF2), .white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }

    private var heroImage: some View {
        AsyncImage(url: FoodCatalog.heroImageURL) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            default:
                ZStack {
                    Theme.greenSoft
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(Theme.green.opacity(0.5))
                }
            }
        }
    }
}

#Preview {
    WelcomeView(onStart: {})
}
