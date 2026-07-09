import SwiftUI

/// A circular progress ring with centered content, used to display calorie
/// intake against a daily target.
struct CalorieRing<Center: View>: View {
    /// Progress in the range 0...1.
    let progress: Double
    let lineWidth: CGFloat
    let gradient: LinearGradient
    let center: () -> Center

    init(
        progress: Double,
        lineWidth: CGFloat = 11,
        gradient: LinearGradient = Theme.ring,
        @ViewBuilder center: @escaping () -> Center
    ) {
        self.progress = progress
        self.lineWidth = lineWidth
        self.gradient = gradient
        self.center = center
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Theme.track, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: max(0, min(1, progress)))
                .stroke(
                    gradient,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.7), value: progress)
            center()
        }
    }
}

/// A donut chart split into the three macronutrient proportions.
struct MacroDonut<Center: View>: View {
    /// Fractions (0...1) for protein, fat and carbs. Should sum to ~1.
    let protein: Double
    let fat: Double
    let carbs: Double
    let thickness: CGFloat
    let center: () -> Center

    init(
        protein: Double,
        fat: Double,
        carbs: Double,
        thickness: CGFloat = 22,
        @ViewBuilder center: @escaping () -> Center
    ) {
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
        self.thickness = thickness
        self.center = center
    }

    private struct Segment: Identifiable {
        let id: Int
        let color: Color
        let start: Double
        let end: Double
    }

    private var segments: [Segment] {
        let values: [(Color, Double)] = [
            (Theme.green, protein),
            (Theme.orange, fat),
            (Theme.blue, carbs)
        ]
        var result: [Segment] = []
        var cursor: Double = 0
        for (index, item) in values.enumerated() {
            let end = cursor + item.1
            result.append(Segment(id: index, color: item.0, start: cursor, end: end))
            cursor = end
        }
        return result
    }

    var body: some View {
        ZStack {
            ForEach(segments) { segment in
                Circle()
                    .trim(from: segment.start, to: segment.end)
                    .stroke(segment.color, style: StrokeStyle(lineWidth: thickness))
                    .rotationEffect(.degrees(-90))
            }
            center()
        }
    }
}
