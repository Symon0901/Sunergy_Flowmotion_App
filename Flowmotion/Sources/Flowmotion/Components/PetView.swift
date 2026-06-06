import SwiftUI

struct PetView: View {
    let state: PetState
    let size: CGFloat

    @State private var animating = false

    var body: some View {
        ZStack {
            // Shadow
            Ellipse()
                .fill(Color.black.opacity(0.06))
                .frame(width: size * 0.55, height: size * 0.08)
                .offset(y: size * 0.42)

            // Sparkles (happy only)
            if state == .happy {
                Group {
                    Circle()
                        .fill(Color(hex: "#FBBF24"))
                        .frame(width: 5, height: 5)
                        .offset(x: -size * 0.3, y: -size * 0.25)
                        .opacity(animating ? 1 : 0.2)

                    Circle()
                        .fill(Color(hex: "#FBBF24"))
                        .frame(width: 4, height: 4)
                        .offset(x: size * 0.3, y: -size * 0.3)
                        .opacity(animating ? 0.3 : 1)

                    Circle()
                        .fill(Color(hex: "#FBBF24"))
                        .frame(width: 4, height: 4)
                        .offset(x: size * 0.25, y: -size * 0.05)
                        .opacity(animating ? 0.8 : 0.3)
                }
            }

            // Body
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(hex: state.bodyColor),
                            Color(hex: state.gradColor)
                        ]),
                        center: UnitPoint(x: 0.5, y: 0.38),
                        startRadius: 0,
                        endRadius: size * 0.45
                    )
                )
                .frame(width: size * 0.85, height: size * 0.85)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: Color(hex: state.gradColor).opacity(0.25), radius: 12, x: 0, y: 6)
                .offset(y: animating ? -4 : 0)

            // Highlight
            Ellipse()
                .fill(Color.white.opacity(0.15))
                .frame(width: size * 0.22, height: size * 0.12)
                .rotationEffect(.degrees(-18))
                .offset(x: -size * 0.12, y: -size * 0.18)

            // Face
            face
                .offset(y: animating ? -4 : 0)
        }
        .frame(width: size, height: size)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true)
            ) {
                animating = true
            }
        }
    }

    @ViewBuilder
    private var face: some View {
        switch state {
        case .happy:
            happyFace
        case .neutral:
            neutralFace
        case .tired:
            tiredFace
        }
    }

    private var happyFace: some View {
        ZStack {
            // Left eye
            Path { path in
                path.move(to: CGPoint(x: -size * 0.15, y: -size * 0.05))
                path.addQuadCurve(
                    to: CGPoint(x: -size * 0.05, y: -size * 0.05),
                    control: CGPoint(x: -size * 0.1, y: -size * 0.12)
                )
            }
            .stroke(Color.white, lineWidth: 3)
            .stroke(Color.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))

            // Right eye
            Path { path in
                path.move(to: CGPoint(x: size * 0.05, y: -size * 0.05))
                path.addQuadCurve(
                    to: CGPoint(x: size * 0.15, y: -size * 0.05),
                    control: CGPoint(x: size * 0.1, y: -size * 0.12)
                )
            }
            .stroke(Color.white, lineWidth: 3)
            .stroke(Color.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))

            // Mouth
            Path { path in
                path.move(to: CGPoint(x: -size * 0.08, y: size * 0.08))
                path.addQuadCurve(
                    to: CGPoint(x: size * 0.08, y: size * 0.08),
                    control: CGPoint(x: 0, y: size * 0.18)
                )
            }
            .stroke(Color.white, lineWidth: 3)
            .stroke(Color.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))

            // Blush
            Circle()
                .fill(Color(hex: "#F472B6"))
                .frame(width: size * 0.1, height: size * 0.1)
                .opacity(0.35)
                .offset(x: -size * 0.22, y: size * 0.02)

            Circle()
                .fill(Color(hex: "#F472B6"))
                .frame(width: size * 0.1, height: size * 0.1)
                .opacity(0.35)
                .offset(x: size * 0.22, y: size * 0.02)
        }
    }

    private var neutralFace: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: size * 0.055, height: size * 0.055)
                .offset(x: -size * 0.12, y: -size * 0.06)

            Circle()
                .fill(Color.white)
                .frame(width: size * 0.055, height: size * 0.055)
                .offset(x: size * 0.12, y: -size * 0.06)

            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .frame(width: size * 0.14, height: 2.5)
                .offset(y: size * 0.08)
        }
    }

    private var tiredFace: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .frame(width: size * 0.16, height: 2.5)
                .offset(x: -size * 0.12, y: -size * 0.06)

            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .frame(width: size * 0.16, height: 2.5)
                .offset(x: size * 0.12, y: -size * 0.06)

            Path { path in
                path.move(to: CGPoint(x: -size * 0.07, y: size * 0.1))
                path.addQuadCurve(
                    to: CGPoint(x: size * 0.07, y: size * 0.1),
                    control: CGPoint(x: 0, y: size * 0.05)
                )
            }
            .stroke(Color.white, lineWidth: 2.5)
            .stroke(Color.white, style: StrokeStyle(lineWidth: 2.5, lineCap: .round))
        }
    }
}
