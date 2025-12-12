//
//  workoutApp.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

@main
struct workoutApp: App {
    @StateObject var userData = UserData()
    @StateObject var customExerciseManager = CustomExerciseManager()
    @StateObject var workoutManager = WorkoutManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
                .environmentObject(customExerciseManager)
                .environmentObject(workoutManager)
        }
    }
}
