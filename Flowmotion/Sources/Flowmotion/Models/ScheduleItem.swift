import Foundation

enum ActivityType: String, CaseIterable {
    case breathe = "breathe"
    case exercise = "exercise"
    case music = "music"
}

@Observable
class ScheduleItem: Identifiable {
    let id = UUID()
    var time: String
    var activity: String
    var completed: Bool
    var type: ActivityType

    init(time: String, activity: String, completed: Bool = false, type: ActivityType) {
        self.time = time
        self.activity = activity
        self.completed = completed
        self.type = type
    }
}
