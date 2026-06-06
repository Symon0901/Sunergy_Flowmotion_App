import SwiftUI

struct BreatheView: View {
    @Bindable var vm: AppViewModel

    @State private var isBreathing = false
    @State private var scale: CGFloat = 1.0
    @State private var breathPhase = "Inhale"
    @State private var breathTimer: Timer?
    @State private var totalSeconds = 0
    @State private var selectedDuration = 3
    @State private var breathCount = 0

    let durations = [1, 3, 5]
    let durationLabels = ["1 min", "3 min", "5 min"]

    var body: some View {
        VStack(spacing: 0) {
            Text("Breathe")
                .font(.cozyTitle)
                .foregroundColor(.cozyTextPrimary)
                .padding(.top, 16)

            Text("Find your calm")
                .font(.cozyBody)
                .foregroundColor(.cozyTextSecondary)
                .padding(.top, 4)

            if !isBreathing {
                // Duration selector
                HStack(spacing: 8) {
                    ForEach(0..<durations.count, id: \.self) { i in
                        Button {
                            selectedDuration = durations[i]
                        } label: {
                            Text(durationLabels[i])
                                .font(.cozyBodyMedium)
                                .foregroundColor(selectedDuration == durations[i] ? .white : .cozyTextSecondary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(selectedDuration == durations[i] ? Color.cozyPrimary : Color.cozyCard)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.cozyBorder, lineWidth: selectedDuration == durations[i] ? 0 : 1)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 24)

                Spacer()

                Button {
                    startBreathing()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.cozyPrimary.opacity(0.1))
                            .frame(width: 200, height: 200)

                        Circle()
                            .fill(Color.cozyPrimary.opacity(0.15))
                            .frame(width: 160, height: 160)

                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.cozyPrimary, .cozyPrimaryLight],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                            .shadow(color: .cozyPrimary.opacity(0.3), radius: 20, x: 0, y: 10)

                        Text("Start")
                            .font(.cozyTitle3)
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(PlainButtonStyle())

                Spacer()
            } else {
                // Active breathing
                Spacer()

                ZStack {
                    // Outer rings
                    Circle()
                        .stroke(Color.cozyPrimary.opacity(0.08), lineWidth: 1)
                        .frame(width: 280, height: 280)

                    Circle()
                        .stroke(Color.cozyPrimary.opacity(0.12), lineWidth: 1)
                        .frame(width: 240, height: 240)

                    // Breathing circle
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [.cozyPrimaryLight, .cozyPrimary]),
                                center: .center,
                                startRadius: 0,
                                endRadius: 80
                            )
                        )
                        .frame(width: 160, height: 160)
                        .scaleEffect(scale)
                        .shadow(color: .cozyPrimary.opacity(0.35), radius: 30 * scale, x: 0, y: 15)

                    // Text
                    VStack(spacing: 6) {
                        Text(breathPhase)
                            .font(.cozyTitle2)
                            .foregroundColor(.white)

                        let remaining = max(0, selectedDuration * 60 - totalSeconds)
                        let rm = remaining / 60
                        let rs = remaining % 60
                        Text(String(format: "%02d:%02d", rm, rs))
                            .font(.cozyBodyMedium)
                            .foregroundColor(.white.opacity(0.8))
                            .monospacedDigit()
                    }
                }

                Spacer()

                Button {
                    stopBreathing()
                } label: {
                    HStack {
                        Spacer()
                        Text("Stop")
                            .font(.cozyBodyMedium)
                            .foregroundColor(.cozyTextPrimary)
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .background(Color.cozyCard)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.cozyBorder, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .padding(.horizontal, 20)
        .background(Color.cozyBackground)
        .onDisappear {
            stopBreathing()
        }
    }

    private func startBreathing() {
        isBreathing = true
        totalSeconds = 0
        breathCount = 0
        breathPhase = "Inhale"
        scale = 1.0

        // 4-4-4-4 box breathing
        breathTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            totalSeconds += 1
            let cycle = totalSeconds % 16

            withAnimation(.easeInOut(duration: 0.5)) {
                if cycle < 4 {
                    breathPhase = "Inhale"
                    scale = 1.0 + (CGFloat(cycle) / 4.0) * 0.4
                } else if cycle < 8 {
                    breathPhase = "Hold"
                    scale = 1.4
                } else if cycle < 12 {
                    breathPhase = "Exhale"
                    scale = 1.4 - (CGFloat(cycle - 8) / 4.0) * 0.4
                } else {
                    breathPhase = "Hold"
                    scale = 1.0
                }
            }

            if totalSeconds >= selectedDuration * 60 {
                stopBreathing()
                vm.addBreathing(minutes: selectedDuration)
            }
        }
    }

    private func stopBreathing() {
        breathTimer?.invalidate()
        breathTimer = nil
        isBreathing = false
        scale = 1.0
    }
}
