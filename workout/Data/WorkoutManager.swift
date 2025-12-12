import Foundation
import Combine
import SwiftUI // Add this import

class WorkoutManager: ObservableObject {
    @Published var workouts: [Workout] = []
    
    private let workoutsKey = "userWorkouts"
    
    init() {
        loadWorkouts()
    }
    
    func addWorkout(_ workout: Workout) {
        workouts.append(workout)
        saveWorkouts()
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
        saveWorkouts()
    }
    
    private func saveWorkouts() {
        if let encoded = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(encoded, forKey: workoutsKey)
        }
    }
    
    private func loadWorkouts() {
        if let data = UserDefaults.standard.data(forKey: workoutsKey) {
            if let decoded = try? JSONDecoder().decode([Workout].self, from: data) {
                self.workouts = decoded
                return
            }
        }
        self.workouts = []
    }
}

