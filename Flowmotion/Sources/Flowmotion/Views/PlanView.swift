import SwiftUI

struct PlanView: View {
    @Bindable var vm: AppViewModel

    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    @State private var showAddSheet = false
    @State private var newTime = Date()
    @State private var newType: ActivityType = .breathe
    @State private var newName = ""

    private let calendar = Calendar.current
    private let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Plan")
                            .font(.cozyTitle)
                            .foregroundColor(.cozyTextPrimary)

                        Text(monthYearString(from: currentDate))
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

                // Monthly Calendar
                MonthlyCalendarView(
                    currentDate: $currentDate,
                    selectedDate: $selectedDate,
                    schedule: vm.schedule
                )
                .padding(.horizontal, 16)
                .padding(.top, 20)

                // Selected date schedule
                if let selected = selectedDate {
                    HStack {
                        Text(dayString(from: selected))
                            .font(.cozyTitle3)
                            .foregroundColor(.cozyTextPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 10)

                    let daySchedule = scheduleForDate(selected)
                    if daySchedule.isEmpty {
                        HStack {
                            Text("No activities planned")
                                .font(.cozyBody)
                                .foregroundColor(.cozyTextTertiary)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    } else {
                        LazyVStack(spacing: 8) {
                            ForEach(daySchedule) { item in
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
                    }
                } else {
                    // Show today by default
                    HStack {
                        Text("Today")
                            .font(.cozyTitle3)
                            .foregroundColor(.cozyTextPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 10)

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
                }

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

    private func scheduleForDate(_ date: Date) -> [ScheduleItem] {
        // For demo, return all schedule items
        // In a real app, you'd filter by date
        return vm.schedule
    }

    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    private func dayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
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

struct MonthlyCalendarView: View {
    @Binding var currentDate: Date
    @Binding var selectedDate: Date?
    let schedule: [ScheduleItem]

    private let calendar = Calendar.current
    private let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        VStack(spacing: 12) {
            // Month navigation
            HStack {
                Button {
                    withAnimation {
                        currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.cozyTextSecondary)
                }

                Spacer()

                Text(monthYearString)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.cozyTextPrimary)

                Spacer()

                Button {
                    withAnimation {
                        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.cozyTextSecondary)
                }
            }
            .padding(.horizontal, 8)

            // Weekday headers
            HStack(spacing: 0) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.cozyTextTertiary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(daysInMonth, id: \.self) { date in
                    if let date = date {
                        DayCell(
                            date: date,
                            isSelected: isSameDay(date, selectedDate),
                            isToday: isToday(date),
                            hasActivity: hasActivity(on: date)
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3)) {
                                selectedDate = date
                            }
                        }
                    } else {
                        Color.clear
                            .frame(height: 36)
                    }
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
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }

    private var daysInMonth: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: monthInterval.start)
        let daysInMonth = calendar.dateComponents([.day], from: monthInterval.start, to: monthInterval.end).day ?? 0

        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)

        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: monthInterval.start) {
                days.append(date)
            }
        }

        // Fill remaining cells to complete the grid
        while days.count % 7 != 0 {
            days.append(nil)
        }

        return days
    }

    private func isSameDay(_ date1: Date?, _ date2: Date?) -> Bool {
        guard let d1 = date1, let d2 = date2 else { return false }
        return calendar.isDate(d1, inSameDayAs: d2)
    }

    private func isToday(_ date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }

    private func hasActivity(on date: Date) -> Bool {
        // Demo: random activity indicator
        let day = calendar.component(.day, from: date)
        return day % 3 == 0 || day % 5 == 0
    }
}

struct DayCell: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let hasActivity: Bool

    private let calendar = Calendar.current

    var body: some View {
        ZStack {
            Circle()
                .fill(isSelected ? Color.cozyPrimary : (isToday ? Color.cozyPrimary.opacity(0.1) : Color.clear))
                .frame(width: 36, height: 36)

            Text("\(calendar.component(.day, from: date))")
                .font(.system(size: 14, weight: isToday || isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : (isToday ? .cozyPrimary : .cozyTextPrimary))
        }
        .frame(height: 36)
        .overlay(
            hasActivity && !isSelected ?
            Circle()
                .fill(Color.cozyPrimary)
                .frame(width: 4, height: 4)
                .offset(y: 12)
            : nil
        )
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
