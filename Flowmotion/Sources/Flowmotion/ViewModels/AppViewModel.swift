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

    var todayIndex: Int {
        Calendar.current.component(.weekday, from: Date()) - 2
    }

    func completeExercise(name: String, minutes: Int) {
        let energyGain = min(minutes * 8, 25)
        let xpGain = min(minutes * 5, 20)
        pet.addEnergy(energyGain)
        pet.addXP(xpGain)
        activitiesToday["exercise", default: 0] += minutes
        lastActivity = "Completed \(minutes) min of \(name)"
        updateTodayTotal()
    }

    func completeScheduleItem(_ item: ScheduleItem) {
        item.completed = true
        pet.addXP(5)
        updateTodayTotal()
    }

    func uncompleteScheduleItem(_ item: ScheduleItem) {
        item.completed = false
        updateTodayTotal()
    }

    func addBreathing(minutes: Int) {
        activitiesToday["breathe", default: 0] += minutes
        pet.addMood(minutes * 3)
        pet.addXP(minutes * 2)
        updateTodayTotal()
    }

    func updateTodayTotal() {
        let total = activitiesToday.values.reduce(0, +)
        if todayIndex >= 0 && todayIndex < 7 {
            weeklyData[todayIndex] = total
        }
    }

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

    func reset() {
        pet = Pet()
        streakCurrent = 0
        activitiesToday = ["breathe": 0, "exercise": 0, "music": 0]
        lastActivity = nil
        customExercises = []
        schedule = [
            ScheduleItem(time: "08:00", activity: "Morning Breathe", type: .breathe),
            ScheduleItem(time: "12:30", activity: "Lunch Walk", type: .exercise),
            ScheduleItem(time: "18:00", activity: "Badminton", type: .exercise),
            ScheduleItem(time: "21:30", activity: "Evening Relax", type: .breathe),
        ]
        weeklyData = [0, 0, 0, 0, 0, 0, 0]
    }
}
