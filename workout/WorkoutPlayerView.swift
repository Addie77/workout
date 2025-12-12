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
    @State private var currentExerciseIndex: Int = 0
    @State private var currentSet: Int = 1

    var currentExercise: Exercise {
        workout.exercises[currentExerciseIndex]
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
                Image("exercise-detail-banner") // Placeholder, ideally dynamic per exercise
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
                        Text("\(currentSet)/\(currentExercise.sets)")
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
                        if currentSet < currentExercise.sets {
                            currentSet += 1
                        } else {
                            // Last set of current exercise
                            if currentExerciseIndex < workout.exercises.count - 1 {
                                currentExerciseIndex += 1
                                currentSet = 1 // Reset for next exercise
                            } else {
                                // Last exercise completed, go to WorkoutCompleteView
                                dismiss() // For now, just dismiss
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
                                dismiss() // If last exercise, just dismiss
                            }
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.gray)
                }
                .padding()
            }
        }
    }
}

struct WorkoutPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPlayerView(workout: ExerciseData.beginnerWorkout)
    }
}
