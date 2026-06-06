import Foundation

enum PetState: String {
    case happy, neutral, tired

    var message: String {
        switch self {
        case .happy:  return "Flowmotion is feeling great!"
        case .neutral: return "Flowmotion could use some care."
        case .tired:   return "Flowmotion needs your help!"
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

@Observable
class Pet {
    var name = "Flowmotion"
    var level = 1
    var energy = 55
    var mood = 55
    var xp = 35

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

    func addXP(_ amount: Int) {
        xp += amount
        if xp >= 100 {
            level += 1
            xp = 0
        }
    }
}
