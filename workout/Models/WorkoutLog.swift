//
//  WorkoutLog.swift
//  workout
//
//  Created by user0862 on 2025/12/13.
//

import Foundation

struct WorkoutLog: Identifiable, Codable {
    var id = UUID()
    var workoutId: UUID
    var date: Date
}
