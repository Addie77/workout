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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
