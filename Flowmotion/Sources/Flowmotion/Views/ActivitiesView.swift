import SwiftUI

struct ActivitiesView: View {
    @Bindable var vm: AppViewModel

    @State private var selectedExercise: Exercise?
    @State private var isActive = false
    @State private var startTime: Date?
    @State private var elapsedSeconds = 0
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 0) {
            if !isActive {
                // Selection
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Move")
                            .font(.cozyTitle)
                            .foregroundColor(.cozyTextPrimary)
                            .padding(.horizontal, 20)
                            .padding(.top, 16)

                        Text("Choose an activity")
                            .font(.cozyBody)
                            .foregroundColor(.cozyTextSecondary)
                            .padding(.horizontal, 20)
                            .padding(.top, 4)
                            .padding(.bottom, 20)

                        LazyVStack(spacing: 10) {
                            ForEach(exercises) { ex in
                                ExerciseCard(exercise: ex) {
                                    startExercise(ex)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                }
            } else {
                // Active timer
                Spacer()

                if let ex = selectedExercise {
                    VStack(spacing: 20) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: ex.colorHex))
                                .frame(width: 72, height: 72)

                            Text(String(ex.name.prefix(1)))
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }

                        let m = elapsedSeconds / 60
                        let s = elapsedSeconds % 60
                        Text(String(format: "%02d:%02d", m, s))
                            .font(.cozyTimer)
                            .foregroundColor(.cozyTextPrimary)
                            .monospacedDigit()

                        Text(ex.name)
                            .font(.cozyTitle3)
                            .foregroundColor(.cozyTextPrimary)

                        Text("Flowmotion is cheering for you")
                            .font(.cozyBody)
                            .foregroundColor(.cozyTextSecondary)
                    }
                }

                Spacer()

                HStack(spacing: 12) {
                    Button {
                        finishExercise()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Finish")
                                .font(.cozyBodyMedium)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical, 14)
                        .background(Color.cozyPrimary)
                        .cornerRadius(14)
                    }

                    Button {
                        cancelExercise()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Cancel")
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
                .padding(.bottom, 30)
            }
        }
        .background(Color.cozyBackground)
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startExercise(_ ex: Exercise) {
        selectedExercise = ex
        isActive = true
        startTime = Date()
        elapsedSeconds = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedSeconds += 1
        }
    }

    private func finishExercise() {
        timer?.invalidate()
        guard let ex = selectedExercise else { return }
        let minutes = max(1, elapsedSeconds / 60)
        vm.completeExercise(name: ex.name, minutes: minutes)
        isActive = false
        selectedExercise = nil
    }

    private func cancelExercise() {
        timer?.invalidate()
        isActive = false
        selectedExercise = nil
        elapsedSeconds = 0
    }
}

struct ExerciseCard: View {
    let exercise: Exercise
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: exercise.colorHex).opacity(0.12))
                        .frame(width: 48, height: 48)

                    Text(String(exercise.name.prefix(1)))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: exercise.colorHex))
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(exercise.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.cozyTextPrimary)

                    Text(exercise.description)
                        .font(.cozyCaption)
                        .foregroundColor(.cozyTextSecondary)
                        .lineLimit(1)
                }

                Spacer()

                IconView(.play, size: 16, color: .cozyTextTertiary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color.cozyCard)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.cozyBorder, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
