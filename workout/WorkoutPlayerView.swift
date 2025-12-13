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
    @State private var isResting: Bool = false

    var currentWorkoutExercise: WorkoutExercise {
        workout.exercises[currentExerciseIndex]
    }
    
    var currentExercise: Exercise {
        currentWorkoutExercise.exercise
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            if workout.exercises.isEmpty {
                Text("No exercises found in this workout.")
                    .foregroundColor(.white)
            } else if isResting {
                RestView(isResting: $isResting, totalTime: 60) {
                    proceedToNextSet()
                }
            } else {
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
                        .background(Color.gray.opacity(0.1).cornerRadius(20)) // Placeholder background

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
                            if isLastSetOfWorkout() {
                                dismiss()
                            } else {
                                isResting = true
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

    private func isLastSetOfWorkout() -> Bool {
        guard !workout.exercises.isEmpty else { return true }
        return currentSet == currentWorkoutExercise.sets && currentExerciseIndex == workout.exercises.count - 1
    }

    private func proceedToNextSet() {
        guard !workout.exercises.isEmpty else { return }
        
        if currentSet < currentWorkoutExercise.sets {
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
    }
}

struct WorkoutPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyExercise = Exercise(
            name: "測試動作",
            img: "Push-ups",
            sets: 3,
            reps: "10",
            videoURL: nil,
            description: "Test Description",
            muscleGroups: "Chest",
            instructions: "Do it",
            commonMistakes: "Don't fail",
            category: "Strength"
        )
        let dummyWorkout = Workout(
            name: "預覽訓練",
            description: "Preview Workout",
            duration: 600,
            calories: 100,
            level: "Beginner",
            exercises: [WorkoutExercise(exercise: dummyExercise, sets: 3)]
        )
        
        return WorkoutPlayerView(workout: dummyWorkout)
    }
}
