import SwiftUI

/// A diary record row: thumbnail, name, meal · time, and calories.
struct DietRecordRow: View {
    let record: DietRecord
    var thumbnailSize: CGFloat = 44
    var showMealColor: Bool = true

    var body: some View {
        HStack(spacing: 12) {
            RemoteThumbnail(url: record.imageURL, size: thumbnailSize)
            VStack(alignment: .leading, spacing: 3) {
                Text(record.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Theme.textPrimary)
                HStack(spacing: 0) {
                    Text(record.meal.label)
                        .foregroundStyle(showMealColor ? Theme.green : Theme.textMuted)
                    Text(" · \(record.time)")
                        .foregroundStyle(Theme.textMuted)
                }
                .font(.system(size: 12))
            }
            Spacer()
            Text("\(record.kcal) kcal")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Theme.orange)
        }
        .padding(.vertical, 11)
    }
}

/// A compact macro tile (label, value/target, mini progress bar).
struct MacroStatTile: View {
    let label: String
    let value: Int
    let target: Int?
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .font(.system(size: 12))
                .foregroundStyle(Theme.textGrey)
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("\(value)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Theme.textPrimary)
                if let target {
                    Text("/\(target)g")
                        .font(.system(size: 11))
                        .foregroundStyle(Theme.textMuted)
                } else {
                    Text("g")
                        .font(.system(size: 11))
                        .foregroundStyle(Theme.textMuted)
                }
            }
            .padding(.top, 4)
            MiniProgressBar(progress: progress, color: color)
                .padding(.top, 7)
        }
        .padding(12)
        .background(Theme.statTileBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var progress: Double {
        guard let target, target > 0 else { return 0 }
        return Double(value) / Double(target)
    }
}
