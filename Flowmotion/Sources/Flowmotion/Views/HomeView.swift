import SwiftUI

struct HomeView: View {
    @Bindable var vm: AppViewModel
    @Binding var selectedTab: TabItem

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Header
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Good Day!")
                            .font(.cozyTitle)
                            .foregroundColor(.cozyTextPrimary)

                        HStack(spacing: 4) {
                            IconView(.flame, size: 14, color: .cozyEnergy)
                            Text("Day \(vm.streakCurrent) streak")
                                .font(.cozyBody)
                                .foregroundColor(.cozyTextSecondary)
                        }
                    }

                    Spacer()

                    Text("Lv.\(vm.pet.level)")
                        .font(.cozyCaptionMedium)
                        .foregroundColor(.cozyGoldText)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.cozyGold)
                        .cornerRadius(999)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                // Pet
                PetView(state: vm.pet.state, size: 180)
                    .padding(.vertical, 20)

                // Status
                PetStatusView(pet: vm.pet)
                    .padding(.horizontal, 20)

                // Today's Plan
                HStack {
                    Text("Today's Plan")
                        .font(.cozyOverline)
                        .foregroundColor(.cozyTextTertiary)
                        .textCase(.uppercase)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 10)

                VStack(spacing: 8) {
                    ForEach(vm.schedule) { item in
                        ScheduleRow(item: item)
                    }
                }
                .padding(.horizontal, 20)

                // Quick Actions
                HStack(spacing: 12) {
                    Button {
                        vm.preferredActivityTab = .breathe
                        selectedTab = .activities
                    } label: {
                        HStack {
                            Spacer()
                            Text("Quick Breathe")
                                .font(.cozyBodyMedium)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical, 14)
                        .background(Color.cozyPrimary)
                        .cornerRadius(14)
                    }

                    Button {
                        vm.preferredActivityTab = .move
                        selectedTab = .activities
                    } label: {
                        HStack {
                            Spacer()
                            Text("Start Moving")
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
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
        .background(Color.cozyBackground)
    }
}

struct ScheduleRow: View {
    let item: ScheduleItem

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(dotColor)
                .frame(width: 8, height: 8)

            VStack(alignment: .leading, spacing: 2) {
                Text(item.activity)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(item.completed ? .cozyTextTertiary : .cozyTextPrimary)
                    .strikethrough(item.completed)

                Text(item.time)
                    .font(.cozyCaption)
                    .foregroundColor(.cozyTextTertiary)
            }

            Spacer()

            if item.completed {
                ZStack {
                    Circle()
                        .fill(Color.cozyPrimary)
                        .frame(width: 20, height: 20)
                    IconView(.check, size: 10, color: .white)
                }
            } else {
                Circle()
                    .stroke(Color.cozyBorder, lineWidth: 2)
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.cozyCard)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.cozyBorder, lineWidth: 1)
        )
        .opacity(item.completed ? 0.55 : 1)
    }

    var dotColor: Color {
        switch item.type {
        case .breathe: return .dotBreathe
        case .exercise: return .dotExercise
        case .music: return .dotMusic
        }
    }
}
