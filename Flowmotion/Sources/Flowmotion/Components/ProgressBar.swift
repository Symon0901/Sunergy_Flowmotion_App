import SwiftUI

struct ProgressBar: View {
    let label: String
    let value: Int
    let color: Color
    let gradient: [Color]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .font(.cozyCaptionMedium)
                    .foregroundColor(.cozyTextPrimary)
                Spacer()
                Text("\(value)%")
                    .font(.cozyCaptionMedium)
                    .foregroundColor(color)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 999)
                        .fill(Color.cozyBorder)
                        .frame(height: 6)

                    RoundedRectangle(cornerRadius: 999)
                        .fill(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(0, geo.size.width * CGFloat(value) / 100), height: 6)
                        .animation(.easeOut(duration: 0.6), value: value)
                }
            }
            .frame(height: 6)
        }
        .padding(16)
        .background(Color.cozyCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.cozyBorder, lineWidth: 1)
        )
    }
}

struct PetStatusView: View {
    let pet: Pet

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 4) {
                Text("Lv.\(pet.level)")
                    .font(.cozyCaptionMedium)
                    .foregroundColor(.cozyGoldText)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.cozyGold)
                    .cornerRadius(999)
            }

            Text(pet.state.message)
                .font(.cozyBody)
                .foregroundColor(.cozyTextTertiary)
                .multilineTextAlignment(.center)

            ProgressBar(label: "Energy", value: pet.energy, color: .cozyEnergy, gradient: [.cozyEnergy, .cozyEnergyLight])
            ProgressBar(label: "Mood", value: pet.mood, color: .cozyMood, gradient: [.cozyMood, .cozyMoodLight])
            ProgressBar(label: "XP", value: pet.xp, color: .cozyXP, gradient: [.cozyXP, .cozyXPLight])
        }
    }
}
