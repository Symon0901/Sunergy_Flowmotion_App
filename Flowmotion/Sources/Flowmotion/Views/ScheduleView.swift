import SwiftUI

struct ScheduleView: View {
    @Bindable var vm: AppViewModel

    @State private var showAddSheet = false
    @State private var newTime = Date()
    @State private var newType: ActivityType = .breathe
    @State private var newName = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Plan")
                        .font(.cozyTitle)
                        .foregroundColor(.cozyTextPrimary)

                    Text("Your wellness schedule")
                        .font(.cozyBody)
                        .foregroundColor(.cozyTextSecondary)
                }

                Spacer()

                Button {
                    showAddSheet = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.cozyPrimary.opacity(0.1))
                            .frame(width: 40, height: 40)
                        IconView(.plus, size: 18, color: .cozyPrimary)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 8) {
                    ForEach(vm.schedule) { item in
                        ScheduleRow(item: item)
                            .onTapGesture {
                                if item.completed {
                                    vm.uncompleteScheduleItem(item)
                                } else {
                                    vm.completeScheduleItem(item)
                                }
                            }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                // Recommendations
                HStack {
                    Text("Recommendations")
                        .font(.cozyOverline)
                        .foregroundColor(.cozyTextTertiary)
                        .textCase(.uppercase)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 10)

                VStack(spacing: 8) {
                    ForEach(recommendations, id: \.self) { rec in
                        HStack {
                            Text(rec)
                                .font(.cozyBody)
                                .foregroundColor(.cozyTextSecondary)
                            Spacer()
                        }
                        .padding(14)
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
        .sheet(isPresented: $showAddSheet) {
            AddScheduleSheet(
                newTime: $newTime,
                newType: $newType,
                newName: $newName,
                onAdd: {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    let timeStr = formatter.string(from: newTime)
                    let name = newName.isEmpty ? "New \(newType.rawValue.capitalized)" : newName
                    let newItem = ScheduleItem(time: timeStr, activity: name, type: newType)
                    vm.schedule.append(newItem)
                    vm.schedule.sort { $0.time < $1.time }
                    newName = ""
                    showAddSheet = false
                },
                onCancel: {
                    showAddSheet = false
                }
            )
        }
    }

    var recommendations: [String] {
        var recs: [String] = []
        if vm.pet.energy < 50 {
            recs.append("Cozymo's energy is low. Try a light walk.")
        }
        if vm.pet.mood < 50 {
            recs.append("Cozymo seems stressed. Try breathing.")
        }
        if recs.isEmpty {
            recs.append("Cozymo is doing well! Keep it up.")
        }
        return recs
    }
}

struct AddScheduleSheet: View {
    @Binding var newTime: Date
    @Binding var newType: ActivityType
    @Binding var newName: String
    let onAdd: () -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Time", selection: $newTime, displayedComponents: .hourAndMinute)

                Picker("Type", selection: $newType) {
                    Text("Breathe").tag(ActivityType.breathe)
                    Text("Exercise").tag(ActivityType.exercise)
                    Text("Music").tag(ActivityType.music)
                }

                TextField("Name", text: $newName)
            }
            .navigationTitle("Add Activity")
            #if canImport(UIKit)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: onAdd)
                }
            }
        }
    }
}
