//
//  Workout.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import Foundation

struct Workout: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let duration: TimeInterval
    let calories: Double
    let level: String
    let exercises: [Exercise]
    
    init(id: UUID = UUID(), name: String, description: String, duration: TimeInterval, calories: Double, level: String, exercises: [Exercise]) {
        self.id = id
        self.name = name
        self.description = description
        self.duration = duration
        self.calories = calories
        self.level = level
        self.exercises = exercises
    }
}

struct Exercise: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    let img: String
    let sets: Int
    let reps: String
    let videoURL: URL?
    let description: String // General description
    let muscleGroups: String
    let instructions: String
    let commonMistakes: String
    let category: String
}
