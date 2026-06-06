import Foundation

struct Exercise: Identifiable {
    let id = UUID()
    let key: String
    let name: String
    let description: String
    let colorHex: String
}

let exercises: [Exercise] = [
    Exercise(key: "badminton", name: "Badminton", description: "Great cardio & fun with friends", colorHex: "#0D9488"),
    Exercise(key: "basketball", name: "Basketball", description: "Team sport for energy boost", colorHex: "#F59E0B"),
    Exercise(key: "running", name: "Running", description: "Clear your mind, build stamina", colorHex: "#EF4444"),
    Exercise(key: "swimming", name: "Swimming", description: "Full body, low impact", colorHex: "#3B82F6"),
    Exercise(key: "yoga", name: "Yoga", description: "Flexibility and calm", colorHex: "#8B5CF6"),
    Exercise(key: "other", name: "Other", description: "Any movement counts", colorHex: "#6B7280"),
]
