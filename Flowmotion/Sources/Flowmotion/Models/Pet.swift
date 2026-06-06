import Foundation

enum PetState: String {
    case happy, neutral, tired

    var message: String {
        switch self {
        case .happy:  return "Cozymo is feeling great!"
        case .neutral: return "Cozymo could use some care."
        case .tired:   return "Cozymo needs your help!"
        }
    }

    var bodyColor: String {
        switch self {
        case .happy:   return "#14B8A6"
        case .neutral: return "#5EEAD4"
        case .tired:   return "#9CA3AF"
        }
    }

    var gradColor: String {
        switch self {
        case .happy:   return "#0D9488"
        case .neutral: return "#2DD4BF"
        case .tired:   return "#6B7280"
        }
    }
}

enum UnlockReward: String, CaseIterable {
    case newColor = "New Pet Color"
    case glowEffect = "Glow Effect"
    case breathePattern478 = "4-7-8 Breathing"
    case breathePatternBox = "Box Breathing"
    case customTheme = "Custom Theme"
    case petAccessory = "Pet Accessory"
    case statsInsight = "Stats Insight"
    case streakShield = "Streak Shield"

    var description: String {
        switch self {
        case .newColor:       return "Unlock a new color for Cozymo"
        case .glowEffect:     return "Cozymo now glows when happy"
        case .breathePattern478: return "Unlock 4-7-8 breathing pattern"
        case .breathePatternBox: return "Unlock box breathing pattern"
        case .customTheme:    return "Unlock dark theme option"
        case .petAccessory:   return "Unlock a cute hat for Cozymo"
        case .statsInsight:   return "Unlock detailed weekly insights"
        case .streakShield:   return "Protect your streak once per week"
        }
    }

    var icon: String {
        switch self {
        case .newColor:       return "paintpalette"
        case .glowEffect:     return "sparkles"
        case .breathePattern478: return "wind"
        case .breathePatternBox: return "square.grid.2x2"
        case .customTheme:    return "moon.fill"
        case .petAccessory:   return "crown"
        case .statsInsight:   return "chart.bar"
        case .streakShield:   return "shield"
        }
    }

    static func reward(for level: Int) -> UnlockReward? {
        switch level {
        case 2:  return .newColor
        case 3:  return .breathePattern478
        case 4:  return .glowEffect
        case 5:  return .statsInsight
        case 6:  return .customTheme
        case 7:  return .petAccessory
        case 8:  return .breathePatternBox
        case 10: return .streakShield
        default: return nil
        }
    }
}

@Observable
class Pet {
    var name = "Cozymo"
    var level = 1
    var energy = 55
    var mood = 55
    var xp = 35
    var unlockedRewards: [UnlockReward] = []

    var state: PetState {
        let avg = Double(energy + mood) / 2.0
        if avg >= 70 { return .happy }
        else if avg >= 40 { return .neutral }
        else { return .tired }
    }

    func addEnergy(_ amount: Int) {
        energy = min(100, energy + amount)
    }

    func addMood(_ amount: Int) {
        mood = min(100, mood + amount)
    }

    func addXP(_ amount: Int) -> UnlockReward? {
        xp += amount
        if xp >= 100 {
            level += 1
            xp = 0
            if let reward = UnlockReward.reward(for: level) {
                unlockedRewards.append(reward)
                return reward
            }
        }
        return nil
    }

    func decay(hours: Int) {
        let decayAmount = min(hours, energy)
        energy = max(20, energy - decayAmount)
        mood = max(20, mood - hours / 2)
    }

    func hasUnlocked(_ reward: UnlockReward) -> Bool {
        unlockedRewards.contains(reward)
    }
}
