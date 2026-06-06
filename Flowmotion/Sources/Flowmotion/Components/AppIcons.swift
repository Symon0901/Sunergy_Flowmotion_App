import SwiftUI

enum AppIcon: String {
    case home, activity, wind, calendar, user
    case play, pause, check, plus, settings, flame, clock

    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            Path { p in
                p.move(to: CGPoint(x: 10, y: 20))
                p.addLine(to: CGPoint(x: 10, y: 10))
                p.addLine(to: CGPoint(x: 2, y: 10))
                p.addLine(to: CGPoint(x: 12, y: 2))
                p.addLine(to: CGPoint(x: 22, y: 10))
                p.addLine(to: CGPoint(x: 14, y: 10))
                p.addLine(to: CGPoint(x: 14, y: 20))
            }
            .stroke(lineWidth: 2)

        case .activity:
            Path { p in
                p.move(to: CGPoint(x: 22, y: 12))
                p.addLine(to: CGPoint(x: 14, y: 4))
                p.addLine(to: CGPoint(x: 2, y: 16))
                p.addLine(to: CGPoint(x: 10, y: 16))
                p.addLine(to: CGPoint(x: 10, y: 22))
                p.addLine(to: CGPoint(x: 14, y: 22))
                p.addLine(to: CGPoint(x: 14, y: 16))
                p.addLine(to: CGPoint(x: 22, y: 16))
                p.closeSubpath()
            }
            .stroke(lineWidth: 2)

        case .wind:
            Path { p in
                p.move(to: CGPoint(x: 2, y: 6))
                p.addCurve(to: CGPoint(x: 14, y: 6), control1: CGPoint(x: 6, y: 2), control2: CGPoint(x: 10, y: 2))
                p.move(to: CGPoint(x: 2, y: 12))
                p.addLine(to: CGPoint(x: 22, y: 12))
                p.move(to: CGPoint(x: 2, y: 18))
                p.addCurve(to: CGPoint(x: 14, y: 18), control1: CGPoint(x: 6, y: 22), control2: CGPoint(x: 10, y: 22))
            }
            .stroke(lineWidth: 2)

        case .calendar:
            Path { p in
                p.move(to: CGPoint(x: 4, y: 6))
                p.addLine(to: CGPoint(x: 20, y: 6))
                p.addLine(to: CGPoint(x: 20, y: 20))
                p.addLine(to: CGPoint(x: 4, y: 20))
                p.closeSubpath()
                p.move(to: CGPoint(x: 4, y: 10))
                p.addLine(to: CGPoint(x: 20, y: 10))
                p.move(to: CGPoint(x: 8, y: 2))
                p.addLine(to: CGPoint(x: 8, y: 6))
                p.move(to: CGPoint(x: 16, y: 2))
                p.addLine(to: CGPoint(x: 16, y: 6))
            }
            .stroke(lineWidth: 2)

        case .user:
            Path { p in
                p.addEllipse(in: CGRect(x: 8, y: 4, width: 8, height: 8))
                p.move(to: CGPoint(x: 4, y: 20))
                p.addCurve(to: CGPoint(x: 20, y: 20), control1: CGPoint(x: 4, y: 14), control2: CGPoint(x: 20, y: 14))
            }
            .stroke(lineWidth: 2)

        case .play:
            Path { p in
                p.move(to: CGPoint(x: 6, y: 4))
                p.addLine(to: CGPoint(x: 20, y: 12))
                p.addLine(to: CGPoint(x: 6, y: 20))
                p.closeSubpath()
            }
            .fill()

        case .pause:
            HStack(spacing: 4) {
                RoundedRectangle(cornerRadius: 2).frame(width: 5, height: 16)
                RoundedRectangle(cornerRadius: 2).frame(width: 5, height: 16)
            }

        case .check:
            Path { p in
                p.move(to: CGPoint(x: 5, y: 12))
                p.addLine(to: CGPoint(x: 10, y: 17))
                p.addLine(to: CGPoint(x: 19, y: 7))
            }
            .stroke(lineWidth: 2.5)

        case .plus:
            Path { p in
                p.move(to: CGPoint(x: 12, y: 4))
                p.addLine(to: CGPoint(x: 12, y: 20))
                p.move(to: CGPoint(x: 4, y: 12))
                p.addLine(to: CGPoint(x: 20, y: 12))
            }
            .stroke(lineWidth: 2)

        case .settings:
            Path { p in
                p.addEllipse(in: CGRect(x: 8, y: 8, width: 8, height: 8))
                p.move(to: CGPoint(x: 12, y: 2))
                p.addLine(to: CGPoint(x: 12, y: 6))
                p.move(to: CGPoint(x: 12, y: 18))
                p.addLine(to: CGPoint(x: 12, y: 22))
                p.move(to: CGPoint(x: 2, y: 12))
                p.addLine(to: CGPoint(x: 6, y: 12))
                p.move(to: CGPoint(x: 18, y: 12))
                p.addLine(to: CGPoint(x: 22, y: 12))
            }
            .stroke(lineWidth: 2)

        case .flame:
            Path { p in
                p.move(to: CGPoint(x: 12, y: 2))
                p.addCurve(to: CGPoint(x: 12, y: 18), control1: CGPoint(x: 4, y: 10), control2: CGPoint(x: 4, y: 16))
                p.addCurve(to: CGPoint(x: 12, y: 12), control1: CGPoint(x: 8, y: 14), control2: CGPoint(x: 8, y: 12))
                p.addCurve(to: CGPoint(x: 12, y: 2), control1: CGPoint(x: 16, y: 8), control2: CGPoint(x: 16, y: 4))
            }
            .stroke(lineWidth: 2)

        case .clock:
            Path { p in
                p.addEllipse(in: CGRect(x: 2, y: 2, width: 20, height: 20))
                p.move(to: CGPoint(x: 12, y: 6))
                p.addLine(to: CGPoint(x: 12, y: 12))
                p.addLine(to: CGPoint(x: 16, y: 12))
            }
            .stroke(lineWidth: 2)
        }
    }
}

struct IconView: View {
    let icon: AppIcon
    let size: CGFloat
    let color: Color

    init(_ icon: AppIcon, size: CGFloat = 24, color: Color = .cozyTextSecondary) {
        self.icon = icon
        self.size = size
        self.color = color
    }

    var body: some View {
        icon.view
            .foregroundColor(color)
            .frame(width: size, height: size)
    }
}
