//
//  UserData.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import Foundation
import Combine
import SwiftUI

class UserData: ObservableObject {
    // Onboarding Data State
    @Published var name: String = ""
    @Published var selectedGoal: GoalSelectionView.Goal = .strength
    @Published var gender: UserStatsView.Gender = .male
    @Published var height: String = "175"
    @Published var weight: String = "70.5"
    @Published var age: String = "28"
    @Published var experience: ActivityLevelView.Experience = .beginner
    @Published var frequency: Int = 3
    
    // Persisted Profile
    @Published var userProfile: UserProfile?
    @Published var workoutLogs: [WorkoutLog] = []
    
    var consecutiveDays: Int {
        let calendar = Calendar.current
        let uniqueDates = Set(workoutLogs.map { calendar.startOfDay(for: $0.date) }).sorted(by: >)
        
        guard let lastWorkoutDate = uniqueDates.first else { return 0 }
        
        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        if lastWorkoutDate != today && lastWorkoutDate != yesterday {
            return 0
        }
        
        var streak = 0
        var currentDateToCheck = lastWorkoutDate
        
        for date in uniqueDates {
            if date == currentDateToCheck {
                streak += 1
                currentDateToCheck = calendar.date(byAdding: .day, value: -1, to: currentDateToCheck)!
            } else {
                break
            }
        }
        
        return streak
    }
    
    private let userProfileKey = "userProfile"
    private let onboardingCompleteKey = "isOnboardingComplete"
    private let workoutLogsKey = "workoutLogs"
    
    init() {
        loadProfile()
        loadWorkoutLogs()
    }
    
    // MARK: - Workout Logging
    
    func logWorkout(workout: Workout, duration: TimeInterval) {
        let adjustedCalories: Double
        if workout.duration > 0 {
            let ratio = duration / workout.duration
            adjustedCalories = workout.calories * ratio
        } else {
            adjustedCalories = workout.calories
        }
        
        let newLog = WorkoutLog(
            workoutId: workout.id,
            date: Date(),
            duration: duration,
            caloriesBurned: adjustedCalories
        )
        
        workoutLogs.append(newLog)
        saveWorkoutLogs()
        print("✅ Workout logged: \(workout.name), Duration: \(duration), Calories: \(adjustedCalories)")
    }
    
    private func saveWorkoutLogs() {
        do {
            let encoded = try JSONEncoder().encode(workoutLogs)
            UserDefaults.standard.set(encoded, forKey: workoutLogsKey)
        } catch {
            print("❌ Failed to save workout logs: \(error)")
        }
    }
    
    private func loadWorkoutLogs() {
        guard let data = UserDefaults.standard.data(forKey: workoutLogsKey) else {
            return
        }
        
        do {
            let logs = try JSONDecoder().decode([WorkoutLog].self, from: data)
            self.workoutLogs = logs
            print("✅ Workout logs loaded: \(logs.count) logs found.")
        } catch {
            print("❌ Failed to decode workout logs: \(error)")
        }
    }
    
    func deleteLogs(ids: Set<UUID>) {
        workoutLogs.removeAll { ids.contains($0.id) }
        saveWorkoutLogs()
    }
    
    func saveProfile() {
        let profile = UserProfile(
            name: name.isEmpty ? "User" : name,
            goal: selectedGoal.rawValue,
            gender: gender.rawValue,
            height: Double(height) ?? 0.0,
            weight: Double(weight) ?? 0.0,
            age: Int(age) ?? 0,
            experience: experience.rawValue,
            frequency: frequency
        )
        
        self.userProfile = profile
        
        do {
            let encoded = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(encoded, forKey: userProfileKey)
            UserDefaults.standard.set(true, forKey: onboardingCompleteKey)
            print("✅ User profile saved successfully: \(profile)")
        } catch {
            print("❌ Failed to save user profile: \(error)")
        }
    }
    
    func saveProfile(_ profile: UserProfile) {
        self.userProfile = profile
        do {
            let encoded = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(encoded, forKey: userProfileKey)
            print("✅ User profile saved successfully: \(profile)")
        } catch {
            print("❌ Failed to save user profile: \(error)")
        }
    }
    
    func updateAndSaveProfile() {
        guard let profile = self.userProfile else {
            print("⚠️ Attempted to update a nil profile.")
            return
        }
        
        do {
            let encoded = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(encoded, forKey: userProfileKey)
            print("✅ User profile updated and saved successfully: \(profile)")
        } catch {
            print("❌ Failed to save updated user profile: \(error)")
        }
    }
    
    
    func loadProfile() {
        guard let data = UserDefaults.standard.data(forKey: userProfileKey) else {
            print("ℹ️ No user profile found in UserDefaults.")
            return
        }
        
        do {
            let profile = try JSONDecoder().decode(UserProfile.self, from: data)
            self.userProfile = profile
            
            // Restore state variables from profile to ensure consistency
            self.name = profile.name
            if let goal = GoalSelectionView.Goal(rawValue: profile.goal) {
                self.selectedGoal = goal
            }
            if let gender = UserStatsView.Gender(rawValue: profile.gender) {
                self.gender = gender
            }
            self.height = String(format: "%.0f", profile.height) // Assuming cm is integer-like usually
            self.weight = String(format: "%.1f", profile.weight)
            self.age = String(profile.age)
            if let experience = ActivityLevelView.Experience(rawValue: profile.experience) {
                self.experience = experience
            }
            self.frequency = profile.frequency
            
            print("✅ User profile loaded successfully: \(profile)")
        } catch {
            print("❌ Failed to decode user profile: \(error)")
        }
    }
    
    func deleteAccount() {
        UserDefaults.standard.removeObject(forKey: userProfileKey)
        UserDefaults.standard.removeObject(forKey: workoutLogsKey)
        UserDefaults.standard.set(false, forKey: onboardingCompleteKey)
        
        self.userProfile = nil
        self.workoutLogs = []
        
        // Reset defaults
        self.name = ""
        self.selectedGoal = .strength
        self.gender = .male
        self.height = "175"
        self.weight = "70.5"
        self.age = "28"
        self.experience = .beginner
        self.frequency = 3
        
        print("🗑️ User account deleted and defaults reset.")
    }
    
}
