import SwiftUI

struct ProfileView: View {
    @Bindable var vm: AppViewModel
    @State private var showResetAlert = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Profile")
                        .font(.cozyTitle)
                        .foregroundColor(.cozyTextPrimary)

                    Text("Your wellness journey")
                        .font(.cozyBody)
                        .foregroundColor(.cozyTextSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)

                // Pet
                PetView(state: vm.pet.state, size: 120)
                    .padding(.vertical, 20)

                // Stats grid
                let total = vm.activitiesToday.values.reduce(0, +)
                HStack(spacing: 12) {
                    StatBox(value: "\(vm.pet.level)", label: "Level")
                    StatBox(value: "\(vm.streakCurrent)", label: "Streak")
                    StatBox(value: "\(total)", label: "Min Today")
                }
                .padding(.horizontal, 20)

                // Today's Activity
                VStack(alignment: .leading, spacing: 12) {
                    Text("Today's Activity")
                        .font(.cozyTitle3)
                        .foregroundColor(.cozyTextPrimary)

                    HStack(spacing: 0) {
                        MetricColumn(label: "Breathe", value: "\(vm.activitiesToday["breathe"] ?? 0) min")
                        MetricColumn(label: "Move", value: "\(vm.activitiesToday["exercise"] ?? 0) min")
                        MetricColumn(label: "Music", value: "\(vm.activitiesToday["music"] ?? 0) min")
                    }
                }
                .padding(16)
                .background(Color.cozyCard)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.cozyBorder, lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.top, 16)

                // Weekly Progress
                VStack(alignment: .leading, spacing: 12) {
                    Text("Weekly Progress")
                        .font(.cozyTitle3)
                        .foregroundColor(.cozyTextPrimary)

                    HStack(spacing: 6) {
                        ForEach(0..<7) { i in
                            let isToday = i == vm.todayIndex
                            let value = vm.weeklyData[i]
                            let bgColor: Color = value > 0 ? .cozyPrimary : .cozyBorder
                            let textColor: Color = value > 0 ? .white : .cozyTextTertiary

                            VStack(spacing: 4) {
                                Text(vm.days[i])
                                    .font(.system(size: 11, weight: isToday ? .semibold : .medium))
                                    .foregroundColor(textColor)

                                Text("\(value)")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(textColor)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(bgColor)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(16)
                .background(Color.cozyCard)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.cozyBorder, lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.top, 12)

                // Last activity
                if let last = vm.lastActivity {
                    HStack {
                        IconView(.clock, size: 14, color: .cozyTextTertiary)
                        Text("Last: \(last)")
                            .font(.cozyCaption)
                            .foregroundColor(.cozyTextTertiary)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }

                // Settings
                Button {
                    showResetAlert = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Reset Data")
                            .font(.cozyBodyMedium)
                            .foregroundColor(.cozyError)
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
                .padding(.top, 20)
                .padding(.bottom, 30)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .background(Color.cozyBackground)
        .alert("Reset all data?", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                vm.reset()
            }
        } message: {
            Text("This will clear all your progress and start fresh.")
        }
    }
}

struct StatBox: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.cozyStatNum)
                .foregroundColor(.cozyTextPrimary)

            Text(label)
                .font(.cozyCaption)
                .foregroundColor(.cozyTextSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.cozyCard)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.cozyBorder, lineWidth: 1)
        )
    }
}

struct MetricColumn: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.cozyTextPrimary)

            Text(label)
                .font(.cozyCaption)
                .foregroundColor(.cozyTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}
