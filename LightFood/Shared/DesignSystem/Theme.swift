import SwiftUI

/// Central design tokens for the app (colors, gradients, radii).
///
/// Values mirror the shared interaction design for 轻卡记 (LightFood).
enum Theme {
    // MARK: Brand

    static let green = Color(hex: 0x22C55E)
    static let greenDark = Color(hex: 0x1FB055)
    static let greenDeep = Color(hex: 0x1FA84E)
    static let orange = Color(hex: 0xFF8A30)
    static let blue = Color(hex: 0x4FC3F7)
    static let blueAlt = Color(hex: 0x4F9DF7)
    static let amber = Color(hex: 0xF0A93B)

    // MARK: Surfaces

    static let background = Color(hex: 0xF5F6F8)
    static let card = Color.white
    static let track = Color(hex: 0xEDEFF2)
    static let barTrack = Color(hex: 0xE7EAEC)
    static let divider = Color(hex: 0xF3F4F6)

    // MARK: Text

    static let textPrimary = Color(hex: 0x2A2F37)
    static let textSecondary = Color(hex: 0x8A9099)
    static let textMuted = Color(hex: 0x9099A2)
    static let textFaint = Color(hex: 0x9CA3AF)
    /// Mid-grey used for secondary body copy (#6B7280).
    static let textGrey = Color(hex: 0x6B7280)
    /// Slate used for small captions/labels (#5B6470).
    static let textSlate = Color(hex: 0x5B6470)

    // MARK: Soft fills (icon chips)

    static let greenSoft = Color(hex: 0xE8F7EE)
    static let orangeSoft = Color(hex: 0xFFF1E6)
    static let blueSoft = Color(hex: 0xEAF3FF)
    static let amberSoft = Color(hex: 0xFDF0E0)
    static let chipBackground = Color(hex: 0xF5F6F8)
    static let statTileBackground = Color(hex: 0xF7F9F8)

    // MARK: Gradients

    static let primaryButton = LinearGradient(
        colors: [Color(hex: 0x25C55E), Color(hex: 0x1FB055)],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let brandMark = LinearGradient(
        colors: [Color(hex: 0x3FD16A), Color(hex: 0x1FA84E)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let ring = LinearGradient(
        colors: [Color(hex: 0x3FD16A), Color(hex: 0x1FB055)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension Color {
    /// Creates a color from a 24-bit RGB hex literal (e.g. `0x22C55E`).
    init(hex: UInt32, alpha: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension View {
    /// Applies the standard white rounded card treatment used across the app.
    func cardStyle(cornerRadius: CGFloat = 20, padding: CGFloat = 18) -> some View {
        self
            .padding(padding)
            .background(Theme.card)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: Color.black.opacity(0.04), radius: 9, x: 0, y: 4)
    }
}
