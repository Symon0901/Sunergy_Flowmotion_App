import SwiftUI

extension Color {
    static let cozyPrimary = Color(hex: "#0D9488")
    static let cozyPrimaryLight = Color(hex: "#14B8A6")
    static let cozyPrimaryDark = Color(hex: "#0F766E")

    static let cozyBackground = Color(hex: "#F9FAFB")
    static let cozyCard = Color.white
    static let cozyBorder = Color(hex: "#F3F4F6")

    static let cozyTextPrimary = Color(hex: "#1F2937")
    static let cozyTextSecondary = Color(hex: "#6B7280")
    static let cozyTextTertiary = Color(hex: "#9CA3AF")

    static let cozyEnergy = Color(hex: "#F59E0B")
    static let cozyEnergyLight = Color(hex: "#FBBF24")
    static let cozyMood = Color(hex: "#0D9488")
    static let cozyMoodLight = Color(hex: "#14B8A6")
    static let cozyXP = Color(hex: "#3B82F6")
    static let cozyXPLight = Color(hex: "#60A5FA")

    static let cozyGold = Color(hex: "#FEF3C7")
    static let cozyGoldText = Color(hex: "#92400E")

    static let cozySuccess = Color(hex: "#10B981")
    static let cozyError = Color(hex: "#EF4444")

    static let dotBreathe = Color(hex: "#0D9488")
    static let dotExercise = Color(hex: "#F59E0B")
    static let dotMusic = Color(hex: "#8B5CF6")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Font {
    static let cozyTitle = Font.system(size: 28, weight: .bold, design: .rounded)
    static let cozyTitle2 = Font.system(size: 22, weight: .bold, design: .rounded)
    static let cozyTitle3 = Font.system(size: 17, weight: .semibold, design: .rounded)
    static let cozyBody = Font.system(size: 15, weight: .regular)
    static let cozyBodyMedium = Font.system(size: 15, weight: .medium)
    static let cozyCaption = Font.system(size: 12, weight: .regular)
    static let cozyCaptionMedium = Font.system(size: 12, weight: .medium)
    static let cozyOverline = Font.system(size: 11, weight: .semibold)
    static let cozyTimer = Font.system(size: 48, weight: .bold, design: .rounded)
    static let cozyStatNum = Font.system(size: 24, weight: .bold, design: .rounded)
}
