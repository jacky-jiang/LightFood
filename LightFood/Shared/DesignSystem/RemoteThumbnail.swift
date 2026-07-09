import SwiftUI

/// Loads a remote food image with a graceful placeholder.
///
/// The URL is supplied by the model layer; this view only renders it, keeping
/// networking concerns out of feature Views.
struct RemoteThumbnail: View {
    let url: URL?
    var size: CGFloat = 44
    var cornerRadius: CGFloat = 12

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                placeholder
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

    private var placeholder: some View {
        ZStack {
            Color(hex: 0xEEF1F0)
            Image(systemName: "fork.knife")
                .font(.system(size: size * 0.36))
                .foregroundStyle(Theme.textMuted)
        }
    }
}
