import SwiftUI

struct ActivitiesView: View {
    @Bindable var vm: AppViewModel
    @State private var subTab: ActivitySubTab = .move

    init(vm: AppViewModel) {
        self.vm = vm
        self._subTab = State(initialValue: vm.preferredActivityTab)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Sub-tab selector
            HStack(spacing: 0) {
                SubTabButton(title: "Move", isActive: subTab == .move) {
                    subTab = .move
                }
                SubTabButton(title: "Breathe", isActive: subTab == .breathe) {
                    subTab = .breathe
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 8)

            Divider()
                .padding(.horizontal, 20)

            if subTab == .move {
                MoveView(vm: vm)
            } else {
                BreatheView(vm: vm)
            }
        }
        .background(Color.cozyBackground)
    }
}

struct SubTabButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 15, weight: isActive ? .semibold : .medium))
                    .foregroundColor(isActive ? .cozyPrimary : .cozyTextTertiary)

                Rectangle()
                    .fill(isActive ? Color.cozyPrimary : Color.clear)
                    .frame(height: 2)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
    }
}

struct MoveView: View {
    @Bindable var vm: AppViewModel
    @State private var selectedExercise: Exercise?
    @State private var isActive = false
    @State private var elapsedSeconds = 0
    @State private var timer: Timer?
    @State private var showAddCustom = false
    @State private var customName = ""
    @State private var customDesc = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                if !isActive {
                    // Custom exercises section
                    if !vm.customExercises.isEmpty {
                        HStack {
                            Text("My Activities")
                                .font(.cozyTitle3)
                                .foregroundColor(.cozyTextPrimary)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 10)

                        LazyVStack(spacing: 10) {
                            ForEach(vm.customExercises) { ex in
                                ExerciseCard(exercise: ex) {
                                    startExercise(ex)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        vm.deleteCustomExercise(ex)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    // Native exercises section
                    HStack {
                        Text("Guided Exercises")
                            .font(.cozyTitle3)
                            .foregroundColor(.cozyTextPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                    LazyVStack(spacing: 10) {
                        ForEach(nativeExercises) { ex in
                            ExerciseCard(exercise: ex) {
                                startExercise(ex)
                            }
                            .overlay(
                                ex.hasGuidance ?
                                GuidanceBadge()
                                    .padding(.top, 8)
                                    .padding(.trailing, 8)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                : nil
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // Add custom button
                    Button {
                        showAddCustom = true
                    } label: {
                        HStack(spacing: 8) {
                            IconView(.plus, size: 16, color: .cozyPrimary)
                            Text("Add My Activity")
                                .font(.cozyBodyMedium)
                                .foregroundColor(.cozyPrimary)
                        }
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.cozyPrimary.opacity(0.08))
                        .cornerRadius(14)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 30)
                } else {
                    // Active timer
                    activeExerciseView
                }
            }
        }
        .sheet(isPresented: $showAddCustom) {
            AddCustomExerciseSheet(
                name: $customName,
                description: $customDesc,
                onAdd: {
                    if !customName.isEmpty {
                        vm.addCustomExercise(
                            name: customName,
                            description: customDesc.isEmpty ? "Custom activity" : customDesc,
                            colorHex: "#0D9488"
                        )
                        customName = ""
                        customDesc = ""
                    }
                    showAddCustom = false
                },
                onCancel: {
                    showAddCustom = false
                }
            )
        }
    }

    @ViewBuilder
    private var activeExerciseView: some View {
        VStack(spacing: 0) {
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

                    Text("Cozymo is cheering for you")
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
                    pauseExercise()
                } label: {
                    HStack {
                        Spacer()
                        Text("Pause")
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

                Button {
                    cancelExercise()
                } label: {
                    HStack {
                        Spacer()
                        Text("Cancel")
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
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
    }

    private func startExercise(_ ex: Exercise) {
        selectedExercise = ex
        isActive = true
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

    private func pauseExercise() {
        timer?.invalidate()
        // In a real app, you'd show a resume button
        // For now, just pause the timer
    }

    private func cancelExercise() {
        timer?.invalidate()
        isActive = false
        selectedExercise = nil
        elapsedSeconds = 0
    }
}

struct GuidanceBadge: View {
    var body: some View {
        Text("GUIDED")
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.cozyPrimary)
            .cornerRadius(4)
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

struct AddCustomExerciseSheet: View {
    @Binding var name: String
    @Binding var description: String
    let onAdd: () -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Activity Name", text: $name)
                TextField("Description (optional)", text: $description)
            }
            .navigationTitle("New Activity")
            #if canImport(UIKit)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: onAdd)
                        .disabled(name.isEmpty)
                }
            }
        }
    }
}
