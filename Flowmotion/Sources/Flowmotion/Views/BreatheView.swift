import SwiftUI

struct BreatheView: View {
    @Bindable var vm: AppViewModel

    @State private var isBreathing = false
    @State private var scale: CGFloat = 1.0
    @State private var breathPhase = "Ready"
    @State private var breathTimer: Timer?
    @State private var totalSeconds = 0
    @State private var selectedDuration = 3
    @State private var ringScale: CGFloat = 0.5
    @State private var ringOpacity: Double = 0.0

    let durations = [1, 3, 5]
    let durationLabels = ["1 min", "3 min", "5 min"]

    var body: some View {
        VStack(spacing: 0) {
            if !isBreathing {
                // Setup state
                Spacer()

                VStack(spacing: 24) {
                    Text("Find your calm")
                        .font(.cozyBody)
                        .foregroundColor(.cozyTextSecondary)

                    // Duration selector
                    HStack(spacing: 12) {
                        ForEach(0..<durations.count, id: \.self) { i in
                            DurationButton(
                                label: durationLabels[i],
                                isSelected: selectedDuration == durations[i]
                            ) {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedDuration = durations[i]
                                }
                            }
                        }
                    }
                }

                Spacer()

                // Start button - large elegant circle
                Button {
                    startBreathing()
                } label: {
                    ZStack {
                        // Outer glow ring
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [.cozyPrimary.opacity(0.15), .clear]),
                                    center: .center,
                                    startRadius: 60,
                                    endRadius: 140
                                )
                            )
                            .frame(width: 280, height: 280)

                        // Main circle
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.cozyPrimary, .cozyPrimaryLight],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 140, height: 140)
                            .shadow(color: .cozyPrimary.opacity(0.35), radius: 30, x: 0, y: 15)

                        // Inner highlight
                        Circle()
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 100, height: 100)
                            .offset(x: -20, y: -20)

                        VStack(spacing: 4) {
                            Text("Start")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.white)

                            Text("Box Breathing")
                                .font(.cozyCaption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())

                Spacer()

                // Breathing pattern hint
                HStack(spacing: 20) {
                    BreathStepLabel(phase: "Inhale", seconds: "4s", color: .cozyPrimary)
                    BreathStepLabel(phase: "Hold", seconds: "4s", color: .cozyEnergy)
                    BreathStepLabel(phase: "Exhale", seconds: "4s", color: .cozyMood)
                    BreathStepLabel(phase: "Hold", seconds: "4s", color: .cozyXP)
                }
                .padding(.bottom, 40)

            } else {
                // Active breathing
                Spacer()

                ZStack {
                    // Expanding rings
                    ForEach(0..<3) { i in
                        Circle()
                            .stroke(Color.cozyPrimary.opacity(0.12 - Double(i) * 0.03), lineWidth: 1)
                            .frame(width: 200 + CGFloat(i) * 60, height: 200 + CGFloat(i) * 60)
                            .scaleEffect(ringScale)
                            .opacity(ringOpacity)
                    }

                    // Breathing circle
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [.cozyPrimaryLight, .cozyPrimary]),
                                center: .center,
                                startRadius: 0,
                                endRadius: 90
                            )
                        )
                        .frame(width: 180, height: 180)
                        .scaleEffect(scale)
                        .shadow(color: .cozyPrimary.opacity(0.4), radius: 40 * scale, x: 0, y: 20)

                    // Phase text
                    VStack(spacing: 8) {
                        Text(breathPhase)
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)

                        let remaining = max(0, selectedDuration * 60 - totalSeconds)
                        let rm = remaining / 60
                        let rs = remaining % 60
                        Text(String(format: "%02d:%02d", rm, rs))
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white.opacity(0.85))
                            .monospacedDigit()
                    }
                }

                Spacer()

                // Current phase indicator
                HStack(spacing: 0) {
                    PhaseDot(phase: "Inhale", isActive: breathPhase == "Inhale", color: .cozyPrimary)
                    PhaseConnector(isActive: breathPhase == "Inhale" || breathPhase == "Hold")
                    PhaseDot(phase: "Hold", isActive: breathPhase == "Hold", color: .cozyEnergy)
                    PhaseConnector(isActive: breathPhase == "Hold" || breathPhase == "Exhale")
                    PhaseDot(phase: "Exhale", isActive: breathPhase == "Exhale", color: .cozyMood)
                    PhaseConnector(isActive: breathPhase == "Exhale" || breathPhase == "Rest")
                    PhaseDot(phase: "Hold", isActive: breathPhase == "Rest", color: .cozyXP)
                }
                .padding(.bottom, 30)

                Button {
                    stopBreathing()
                } label: {
                    HStack {
                        Spacer()
                        Text("Stop")
                            .font(.cozyBodyMedium)
                            .foregroundColor(.cozyTextSecondary)
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
                .padding(.bottom, 20)
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
        breathPhase = "Inhale"
        scale = 1.0
        ringScale = 0.5
        ringOpacity = 0.0

        withAnimation(.easeInOut(duration: 4)) {
            scale = 1.4
            ringScale = 1.0
            ringOpacity = 1.0
        }

        breathTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            totalSeconds += 1
            let cycle = totalSeconds % 16

            withAnimation(.easeInOut(duration: 3.5)) {
                if cycle < 4 {
                    breathPhase = "Inhale"
                    scale = 1.0 + (CGFloat(cycle) / 4.0) * 0.4
                    ringScale = 0.5 + (CGFloat(cycle) / 4.0) * 0.5
                    ringOpacity = 0.3 + (CGFloat(cycle) / 4.0) * 0.7
                } else if cycle < 8 {
                    breathPhase = "Hold"
                    scale = 1.4
                    ringScale = 1.0
                    ringOpacity = 1.0
                } else if cycle < 12 {
                    breathPhase = "Exhale"
                    scale = 1.4 - (CGFloat(cycle - 8) / 4.0) * 0.4
                    ringScale = 1.0 - (CGFloat(cycle - 8) / 4.0) * 0.5
                    ringOpacity = 1.0 - (CGFloat(cycle - 8) / 4.0) * 0.7
                } else {
                    breathPhase = "Rest"
                    scale = 1.0
                    ringScale = 0.5
                    ringOpacity = 0.3
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
        ringScale = 0.5
        ringOpacity = 0.0
    }
}

struct DurationButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.cozyBodyMedium)
                .foregroundColor(isSelected ? .white : .cozyTextSecondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(isSelected ? Color.cozyPrimary : Color.cozyCard)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.cozyBorder, lineWidth: isSelected ? 0 : 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BreathStepLabel: View {
    let phase: String
    let seconds: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(phase)
                .font(.cozyCaptionMedium)
                .foregroundColor(.cozyTextSecondary)
            Text(seconds)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(color)
        }
    }
}

struct PhaseDot: View {
    let phase: String
    let isActive: Bool
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(isActive ? color : Color.cozyBorder)
                    .frame(width: isActive ? 12 : 8, height: isActive ? 12 : 8)

                if isActive {
                    Circle()
                        .stroke(color.opacity(0.3), lineWidth: 2)
                        .frame(width: 20, height: 20)
                }
            }

            Text(phase)
                .font(.system(size: 10, weight: isActive ? .semibold : .regular))
                .foregroundColor(isActive ? color : .cozyTextTertiary)
        }
    }
}

struct PhaseConnector: View {
    let isActive: Bool

    var body: some View {
        Rectangle()
            .fill(isActive ? Color.cozyPrimary.opacity(0.3) : Color.cozyBorder)
            .frame(width: 24, height: 1)
            .offset(y: -10)
    }
}
