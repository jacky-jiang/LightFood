import SwiftUI

/// The full-width gradient primary action button used across the app.
struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Theme.primaryButton)
                .clipShape(Capsule())
                .shadow(color: Theme.green.opacity(0.3), radius: 12, x: 0, y: 12)
        }
        .buttonStyle(.plain)
    }
}

/// A card header row with a title and an optional "更多 ›" trailing action.
struct SectionHeader: View {
    let title: String
    var trailingTitle: String? = nil
    var trailingAction: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Theme.textPrimary)
            Spacer()
            if let trailingTitle {
                Button {
                    trailingAction?()
                } label: {
                    Text(trailingTitle)
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.textMuted)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

/// A thin rounded progress bar (used for macro breakdowns).
struct MiniProgressBar: View {
    /// Progress in the range 0...1.
    let progress: Double
    var color: Color = Theme.green
    var height: CGFloat = 4

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Theme.barTrack)
                Capsule()
                    .fill(color)
                    .frame(width: max(0, min(1, progress)) * geo.size.width)
            }
        }
        .frame(height: height)
    }
}

/// The small stacked "brand leaf" mark used in headers and the splash.
struct BrandMark: View {
    var size: CGFloat = 34
    var cornerRadius: CGFloat = 11

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Theme.brandMark)
            .frame(width: size, height: size)
            .overlay(
                Image(systemName: "leaf.fill")
                    .font(.system(size: size * 0.42))
                    .foregroundStyle(.white)
            )
    }
}
