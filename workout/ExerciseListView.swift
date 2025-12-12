//
//  ExerciseListView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct ExerciseListView: View {
    let categoryName: String

    var body: some View {
        let categoryExercises = ExerciseData.allExercises.filter { $0.category == categoryName }
        ScrollView {
            VStack(alignment: .leading) {
                Text("共 \(categoryExercises.count) 個動作")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                LazyVStack(spacing: 0) {
                    ForEach(categoryExercises) { exercise in
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                            ExerciseRow(image: String(exercise.name.prefix(2)), name: exercise.name, reps: exercise.reps)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(categoryName)
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseListView(categoryName: "胸肌") // Changed to "胸肌" to match muscle groups in ExerciseData
        }
    }
}
