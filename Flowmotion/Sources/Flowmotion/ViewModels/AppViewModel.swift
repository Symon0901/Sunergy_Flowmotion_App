import Foundation
import SwiftUI

@Observable
class AppViewModel {
    var pet = Pet()
    var streakCurrent = 3
    var streakBest = 7
    var activitiesToday: [String: Int] = ["breathe": 0, "exercise": 0, "music": 0]
    var lastActivity: String?
    var showLevelUp = false
    var lastUnlockedReward: UnlockReward?

    var customExercises: [Exercise] = []
    var preferredActivityTab: ActivitySubTab = .move

    var schedule: [ScheduleItem] = [
        ScheduleItem(time: "08:00", activity: "Morning Breathe", type: .breathe),
        ScheduleItem(time: "12:30", activity: "Lunch Walk", type: .exercise),
        ScheduleItem(time: "18:00", activity: "Badminton", type: .exercise),
        ScheduleItem(time: "21:30", activity: "Evening Relax", type: .breathe),
    ]

    var weeklyData: [Int] = [35, 20, 50, 15, 30, 0, 0]
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var lastActiveDate: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }()

    var todayIndex: Int {
        Calendar.current.component(.weekday, from: Date()) - 2
    }

    init() {
        checkDailyReset()
    }

    // MARK: - Daily Reset

    func checkDailyReset() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())

        guard today != lastActiveDate else { return }

        // Calculate hours passed for decay
        if let lastDate = formatter.date(from: lastActiveDate) {
            let hours = Calendar.current.dateComponents([.hour], from: lastDate, to: Date()).hour ?? 0
            pet.decay(hours: max(hours, 1))
        }

        // Check streak
        let yesterday = formatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
        let hadActivityYesterday = activitiesToday.values.reduce(0, +) > 0

        if lastActiveDate == yesterday && hadActivityYesterday {
            streakCurrent += 1
            streakBest = max(streakBest, streakCurrent)
        } else if lastActiveDate != yesterday {
            streakCurrent = 0
        }

        // Reset daily data
        activitiesToday = ["breathe": 0, "exercise": 0, "music": 0]
        for item in schedule {
            item.completed = false
        }

        lastActiveDate = today
    }

    // MARK: - Activity + Schedule Integration

    func completeExercise(name: String, minutes: Int) {
        let energyGain = min(minutes * 8, 25)
        let xpGain = min(minutes * 5, 20)
        pet.addEnergy(energyGain)

        if let reward = pet.addXP(xpGain) {
            lastUnlockedReward = reward
            showLevelUp = true
        }

        activitiesToday["exercise", default: 0] += minutes
        lastActivity = "Completed \(minutes) min of \(name)"

        // Auto check-in matching schedule item
        autoCheckInSchedule(type: .exercise)
        updateTodayTotal()
    }

    func addBreathing(minutes: Int) {
        activitiesToday["breathe", default: 0] += minutes
        pet.addMood(minutes * 3)

        if let reward = pet.addXP(minutes * 2) {
            lastUnlockedReward = reward
            showLevelUp = true
        }

        lastActivity = "Completed \(minutes) min of breathing"

        // Auto check-in matching schedule item
        autoCheckInSchedule(type: .breathe)
        updateTodayTotal()
    }

    private func autoCheckInSchedule(type: ActivityType) {
        if let match = schedule.first(where: { $0.type == type && !$0.completed }) {
            match.completed = true
            // Small bonus XP for schedule consistency
            _ = pet.addXP(3)
        }
    }

    func completeScheduleItem(_ item: ScheduleItem) {
        item.completed = true
        if let reward = pet.addXP(5) {
            lastUnlockedReward = reward
            showLevelUp = true
        }
        updateTodayTotal()
    }

    func uncompleteScheduleItem(_ item: ScheduleItem) {
        item.completed = false
        updateTodayTotal()
    }

    func updateTodayTotal() {
        let total = activitiesToday.values.reduce(0, +)
        if todayIndex >= 0 && todayIndex < 7 {
            weeklyData[todayIndex] = total
        }
    }

    // MARK: - Custom Exercises

    func addCustomExercise(name: String, description: String, colorHex: String) {
        let ex = Exercise(
            key: "custom_\(UUID().uuidString.prefix(8))",
            name: name,
            description: description,
            colorHex: colorHex,
            isNative: false,
            hasGuidance: false
        )
        customExercises.append(ex)
    }

    func deleteCustomExercise(_ exercise: Exercise) {
        customExercises.removeAll { $0.id == exercise.id }
    }

    // MARK: - Reset

    func reset() {
        pet = Pet()
        streakCurrent = 0
        activitiesToday = ["breathe": 0, "exercise": 0, "music": 0]
        lastActivity = nil
        lastUnlockedReward = nil
        customExercises = []
        preferredActivityTab = .move
        schedule = [
            ScheduleItem(time: "08:00", activity: "Morning Breathe", type: .breathe),
            ScheduleItem(time: "12:30", activity: "Lunch Walk", type: .exercise),
            ScheduleItem(time: "18:00", activity: "Badminton", type: .exercise),
            ScheduleItem(time: "21:30", activity: "Evening Relax", type: .breathe),
        ]
        weeklyData = [0, 0, 0, 0, 0, 0, 0]
        lastActiveDate = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: Date())
        }()
    }
}
