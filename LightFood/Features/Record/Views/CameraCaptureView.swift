import SwiftUI

/// A stylised camera capture screen. Tapping the shutter simulates recognition
/// and opens the detected food's detail screen.
struct CameraCaptureView: View {
    @Binding var path: [AppRoute]
    @Environment(\.dismiss) private var dismiss

    private let catalog = FoodCatalog()

    /// The food used to demo recognition (matches the design's default).
    private var detectedFood: Food {
        catalog.foods().first { $0.id == "chicken" } ?? catalog.foods()[0]
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("拍照识别")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                Spacer()
                Color.clear.frame(width: 20, height: 20)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)

            ZStack {
                AsyncImage(url: detectedFood.imageURL) { phase in
                    if case .success(let image) = phase {
                        image.resizable().scaledToFill()
                    } else {
                        Color(white: 0.15)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

                RadialGradient(
                    colors: [.clear, .black.opacity(0.45)],
                    center: .center,
                    startRadius: 90,
                    endRadius: 260
                )

                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.9), lineWidth: 2)
                    .frame(width: 230, height: 230)

                VStack {
                    Spacer()
                    Text("请将食物置于取景框内")
                        .font(.system(size: 13))
                        .foregroundStyle(.white)
                        .padding(.bottom, 40)
                }
            }

            HStack {
                controlButton(systemImage: "photo.on.rectangle", tint: .white)
                Spacer()
                Button {
                    path.append(.foodDetail(detectedFood))
                } label: {
                    Circle()
                        .fill(.white)
                        .frame(width: 74, height: 74)
                        .overlay(
                            Circle().strokeBorder(Color.white.opacity(0.35), lineWidth: 5)
                        )
                }
                .buttonStyle(.plain)
                Spacer()
                controlButton(systemImage: "magnifyingglass", tint: Theme.green)
            }
            .padding(.horizontal, 40)
            .padding(.top, 26)
            .padding(.bottom, 30)
            .background(Color.black)
        }
        .background(Color.black.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }

    private func controlButton(systemImage: String, tint: Color) -> some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(Color(white: 0.16))
            .frame(width: 46, height: 46)
            .overlay(
                Image(systemName: systemImage)
                    .font(.system(size: 20))
                    .foregroundStyle(tint)
            )
    }
}

#Preview {
    NavigationStack {
        CameraCaptureView(path: .constant([]))
    }
}
