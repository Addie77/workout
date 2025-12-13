//
//  EditWorkoutExercisesView.swift
//  workout
//
//  Created by Gemini on 2025/12/13.
//

import SwiftUI

struct EditWorkoutExercisesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var workoutForEditing: Workout
    let originalWorkout: Workout
    
    @State private var showingAddExerciseSheet = false

    init(workout: Workout) {
        self.originalWorkout = workout
        _workoutForEditing = State(initialValue: workout)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("計畫名稱")) {
                    TextField("名稱", text: $workoutForEditing.name)
                }

                Section(header: Text("動作")) {
                    ForEach($workoutForEditing.exercises) { $exercise in
                        VStack(alignment: .leading) {
                            Text(exercise.exercise.name).font(.headline)
                            Stepper("組數: \(exercise.sets)", value: $exercise.sets, in: 1...20)
                        }
                    }
                    .onDelete(perform: deleteExercise)
                    
                    Button(action: {
                        showingAddExerciseSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("新增動作")
                        }
                    }
                }
            }
            .navigationTitle("編輯計畫")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("儲存") {
                        workoutManager.updateWorkout(workoutForEditing)
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingAddExerciseSheet) {
                AddExerciseToWorkoutView(workoutExercises: $workoutForEditing.exercises)
            }
        }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        workoutForEditing.exercises.remove(atOffsets: offsets)
    }
}
