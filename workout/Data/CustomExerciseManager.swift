//
//  CustomExerciseManager.swift
//  workout
//
//  Created by user0862 on 2025/12/6.
//

import Foundation
import Combine

class CustomExerciseManager: ObservableObject {
    @Published var customExercises: [Exercise] = []
    
    private let customExercisesKey = "customExercises"
    
    init() {
        loadCustomExercises()
    }
    
    func addExercise(_ exercise: Exercise) {
        customExercises.append(exercise)
        saveCustomExercises()
    }
    
    func addExercises(_ exercises: [Exercise]) {
        customExercises.append(contentsOf: exercises)
        saveCustomExercises()
    }
    
    func deleteExercise(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            customExercises.remove(at: index)
        }
        saveCustomExercises()
    }
    
    func deleteExercises(ids: Set<UUID>) {
        customExercises.removeAll { ids.contains($0.id) }
        saveCustomExercises()
    }

    func updateExercise(_ exercise: Exercise) {
        if let index = customExercises.firstIndex(where: { $0.id == exercise.id }) {
            customExercises[index] = exercise
            saveCustomExercises()
        }
    }
    
    func deleteAllExercises() {
        customExercises.removeAll()
        UserDefaults.standard.removeObject(forKey: customExercisesKey)
    }
    
    private func saveCustomExercises() {
        do {
            let data = try JSONEncoder().encode(customExercises)
            UserDefaults.standard.set(data, forKey: customExercisesKey)
        } catch {
            print("Error saving custom exercises: \(error)")
        }
    }
    
    private func loadCustomExercises() {
        guard let data = UserDefaults.standard.data(forKey: customExercisesKey) else { return }
        
        do {
            customExercises = try JSONDecoder().decode([Exercise].self, from: data)
        } catch {
            print("Error loading custom exercises: \(error)")
        }
    }
}
