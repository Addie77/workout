//
//  ExerciseListView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct ExerciseListView: View {
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    let categoryName: String

    var body: some View {
        let categoryExercises = categoryName == "器材" ? EquipmentData.allEquipment : ExerciseData.allExercises.filter { $0.category == categoryName }
        let customCategoryExercises = customExerciseManager.customExercises.filter { $0.category == categoryName }
        let allCategoryExercises = categoryExercises + customCategoryExercises
        
        ScrollView {
            VStack(alignment: .leading) {
                Text("共 \(allCategoryExercises.count) 個動作")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                LazyVStack(spacing: 0) {
                    ForEach(allCategoryExercises) { exercise in
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
                .environmentObject(CustomExerciseManager())
        }
    }
}
