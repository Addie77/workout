//
//  Workout.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let duration: TimeInterval
    let calories: Double
    let level: String
    let exercises: [Exercise]
}

struct Exercise: Identifiable, Codable {
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
