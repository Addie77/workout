//
//  RenameWorkoutView.swift
//  workout
//
//  Created by Gemini on 2025/12/13.
//

import SwiftUI

struct RenameWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var newName: String
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
        _newName = State(initialValue: workout.name)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("計畫名稱")) {
                    TextField("輸入新名稱", text: $newName)
                }
            }
            .navigationTitle("重新命名")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("儲存") {
                        saveChanges()
                        dismiss()
                    }
                    .disabled(newName.isEmpty)
                }
            }
        }
    }
    
    private func saveChanges() {
        var updatedWorkout = workout
        updatedWorkout.name = newName
        workoutManager.updateWorkout(updatedWorkout)
    }
}
