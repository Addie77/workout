//
//  WorkoutPlayerView.swift
//  workout
//
//  Created by user0862 on 2025/12/12.
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
    
    // New State Variables
    @State private var isResting = false
    @State private var showingExerciseDetail = false

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

                // Image with Tap Gesture
                Button(action: {
                    showingExerciseDetail = true
                }) {
                    Image(currentExercise.img)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding()
                }

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
                        Text(currentExercise.reps.replacingOccurrences(of: " 次", with: "")) 
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    }
                }

                Spacer()

                // Controls
                VStack(spacing: 16) {
                    Button(action: {
                        handleCompleteSet()
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
                           previousExercise()
                        }
                        Spacer()
                        Button("跳過動作") {
                            skipExercise()
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
        .fullScreenCover(isPresented: $isResting) {
            RestView(isResting: $isResting, totalTime: 60, onFinish: {
                advanceAfterRest()
            })
        }
        .sheet(isPresented: $showingExerciseDetail) {
            ExerciseDetailView(exercise: currentExercise)
        }
    }
    
    private func handleCompleteSet() {
        if currentExerciseIndex == workout.exercises.count - 1 && currentSet == currentWorkoutExercise.sets {
             finishWorkout()
        } else {
            isResting = true
        }
    }
    
    private func advanceAfterRest() {
        if currentSet < currentWorkoutExercise.sets {
            currentSet += 1
        } else {
            if currentExerciseIndex < workout.exercises.count - 1 {
                currentExerciseIndex += 1
                currentSet = 1
            } else {
                finishWorkout()
            }
        }
    }
    
    private func previousExercise() {
        if currentExerciseIndex > 0 {
            currentExerciseIndex -= 1
            currentSet = 1 
        }
    }
    
    private func skipExercise() {
        if currentExerciseIndex < workout.exercises.count - 1 {
            currentExerciseIndex += 1
            currentSet = 1
        } else {
            finishWorkout()
        }
    }
    
    private func finishWorkout() {
        workoutDuration = Date().timeIntervalSince(startTime)
        userData.logWorkout(workout: workout)
        showCompletionView = true
    }
}

struct WorkoutPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPlayerView(workout: ExerciseData.beginnerWorkout)
            .environmentObject(UserData())
    }
}
