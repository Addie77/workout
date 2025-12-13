//
//  AddExerciseToWorkoutView.swift
//  workout
//
//  Created by Gemini on 2025/12/13.
//

import SwiftUI

struct AddExerciseToWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    
    @Binding var workoutExercises: [WorkoutExercise]
    
    private var allExercises: [Exercise] {
        (ExerciseData.allExercises + customExerciseManager.customExercises).unique()
    }
    
    private var availableExercises: [Exercise] {
        let existingExerciseIDs = Set(workoutExercises.map { $0.exercise.id })
        return allExercises.filter { !existingExerciseIDs.contains($0.id) }
    }

    var body: some View {
        NavigationView {
            List(availableExercises) { exercise in
                Button(action: {
                    addExercise(exercise)
                }) {
                    HStack {
                        Text(exercise.name)
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle("新增動作")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addExercise(_ exercise: Exercise) {
        let newWorkoutExercise = WorkoutExercise(exercise: exercise, sets: 3) // Default to 3 sets
        workoutExercises.append(newWorkoutExercise)
        // Note: This dismisses after adding one exercise.
        // This is a simple UX, user can re-open to add more.
        dismiss()
    }
}
