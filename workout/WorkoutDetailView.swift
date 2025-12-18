//
//  WorkoutDetailView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI
import UIKit

struct WorkoutDetailView: View {
    @State var workout: Workout
    @State private var selectedExercise: Exercise?
    @State private var showingWorkoutPlayer = false
    @State private var isEditing = false
    @EnvironmentObject var workoutManager: WorkoutManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("workout-detail-banner") // Placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(20)

                Text(workout.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)

                HStack(spacing: 24) {
                    Label("\(Int(workout.duration / 60)) 分鐘", systemImage: "clock")
                    Label("\(Int(workout.calories)) 卡 (估計)", systemImage: "flame.fill")
                    Text("🏅 \(workout.level)等級")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 4)

                Text("訓練動作")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 24)

                VStack(spacing: 16) {
                    ForEach(workout.exercises) { workoutExercise in
                        Button(action: { selectedExercise = workoutExercise.exercise }) {
                            ExerciseRow(exercise: workoutExercise.exercise, workoutExercise: workoutExercise)
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 120) // Add bottom padding to prevent overlap with the "開始訓練" button
            }
            .padding()
        }
        .overlay(
            VStack {
                Spacer()
                LinearGradient(gradient: Gradient(colors: [.clear, Color(UIColor.systemBackground).opacity(0.9), Color(UIColor.systemBackground)]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 150)
            }
            .edgesIgnoringSafeArea(.bottom)
        )
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    showingWorkoutPlayer = true
                }) {
                    Text("開始訓練 (\(workout.exercises.count) 個動作)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        )
        .navigationTitle(workout.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("編輯") {
                    isEditing = true
                }
            }
        }
        .sheet(item: $selectedExercise) { exercise in
            ExerciseDetailView(exercise: exercise)
        }
        .fullScreenCover(isPresented: $showingWorkoutPlayer) {
            WorkoutPlayerView(workout: workout)
        }
        .sheet(isPresented: $isEditing) {
            EditWorkoutExercisesView(workout: workout)
        }
    }
}

struct ExerciseRow: View {
    let exercise: Exercise
    var workoutExercise: WorkoutExercise? = nil

    var body: some View {
        HStack(spacing: 16) {
            ExerciseImageView(assetImageName: exercise.assetImageName, userImageBase64: exercise.userImageBase64)
                .frame(width: 64, height: 64)
                .clipped()
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                if let we = workoutExercise {
                    Text("\(we.sets) 組 x \(we.reps)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(12)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(15)
        .foregroundColor(.primary)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutDetailView(workout: ExerciseData.beginnerWorkout)
        }
    }
}
