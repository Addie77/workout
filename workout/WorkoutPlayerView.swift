//
//  WorkoutPlayerView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct WorkoutPlayerView: View {
    let workout: Workout
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    
    @State private var currentExerciseIndex: Int = 0
    @State private var currentSet: Int = 1
    @State private var showCompletionView = false
    @State private var startTime = Date()
    @State private var workoutDuration: TimeInterval = 0

    var currentWorkoutExercise: WorkoutExercise {
        workout.exercises[currentExerciseIndex]
    }
    
    var currentExercise: Exercise {
        currentWorkoutExercise.exercise
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("動作 \(currentExerciseIndex + 1) / \(workout.exercises.count)")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(currentExercise.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button("結束") {
                        dismiss()
                    }
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(20)
                }
                .padding()

                // Image
                Image(currentExercise.img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding()

                Spacer()

                // Sets and Reps
                HStack(spacing: 60) {
                    VStack {
                        Text("組數")
                            .font(.title)
                            .foregroundColor(.gray)
                        Text("\(currentSet)/\(currentWorkoutExercise.sets)")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    }
                    VStack {
                        Text("次數")
                            .font(.title)
                            .foregroundColor(.gray)
                        Text(currentExercise.reps.replacingOccurrences(of: " 次", with: "")) // Remove " 次" for cleaner display
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    }
                }

                Spacer()

                // Controls
                VStack(spacing: 16) {
                    Button(action: {
                        if currentSet < currentWorkoutExercise.sets {
                            currentSet += 1
                        } else {
                            // Last set of current exercise
                            if currentExerciseIndex < workout.exercises.count - 1 {
                                currentExerciseIndex += 1
                                currentSet = 1 // Reset for next exercise
                            } else {
                                // Last exercise completed, go to WorkoutCompleteView
                                workoutDuration = Date().timeIntervalSince(startTime)
                                userData.logWorkout(workout: workout)
                                showCompletionView = true
                            }
                        }
                    }) {
                        Text("完成一組 (休息 60s)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }


                    HStack {
                        Button("上一個") {
                            if currentExerciseIndex > 0 {
                                currentExerciseIndex -= 1
                                currentSet = 1 // Reset sets when going back
                            }
                        }
                        Spacer()
                        Button("跳過動作") {
                            if currentExerciseIndex < workout.exercises.count - 1 {
                                currentExerciseIndex += 1
                                currentSet = 1 // Reset sets for skipped exercise
                            } else {
                                // If last exercise, log and show completion
                                workoutDuration = Date().timeIntervalSince(startTime)
                                userData.logWorkout(workout: workout)
                                showCompletionView = true
                            }
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.gray)
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $showCompletionView) {
            WorkoutCompleteView(workout: workout, duration: workoutDuration, onDismiss: {
                dismiss()
            })
        }
    }
}

struct WorkoutPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPlayerView(workout: ExerciseData.beginnerWorkout)
            .environmentObject(UserData())
    }
}
