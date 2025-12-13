//
//  ExerciseDetailView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    @State private var selectedTab: Int = 0
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @State private var showingEditView = false

    private var isCustom: Bool {
        customExerciseManager.customExercises.contains(where: { $0.id == exercise.id })
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Removed Text(exercise.name) as it's now in navigationTitle
                    
                    Text(exercise.muscleGroups)
                        .font(.headline)
                        .foregroundColor(.secondary)

                    // The app will look for an image in the asset catalog with the same name as the exercise.
                    // For example, for "深蹲 (Squats)", you should add an image set named "深蹲 (Squats)".
                    Image(exercise.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(20)
                        .background(Color.gray.opacity(0.1).cornerRadius(20))

                    Picker("Details", selection: $selectedTab) {
                        Text("動作指引").tag(0)
                        Text("常見錯誤").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if selectedTab == 0 {
                        Text(exercise.instructions)
                        .font(.body)
                        .foregroundColor(.secondary)
                        
                        // 範例：如果存在影片連結，就顯示它
                        if let videoURL = exercise.videoURL {
                            Link(destination: videoURL) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("觀看動作示範影片")
                                }
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding(.vertical, 8)
                            }
                            .padding(.top, 4)
                        } else {
                            // Placeholder for when videoURL is nil
                            Link(destination: URL(string: "https://www.youtube.com/watch?v=2J9zsFwhF2Q")!) { // 使用替代文字的 URL
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("觀看動作示範影片 (暫無連結)")
                                }
                                .font(.headline)
                                .foregroundColor(.gray) // 如果沒有實際連結，顏色變灰
                                .padding(.vertical, 8)
                            }
                            .padding(.top, 4)
                        }
                    } else {
                        Text(exercise.commonMistakes)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle(exercise.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isCustom {
                        Button(action: {
                            showingEditView = true
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            EditExerciseView(exercise: exercise)
        }
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: Exercise(name: "深蹲 (Squats)",img: "exercise-detail-banner", sets: 3, reps: "10 次", videoURL: URL(string: "https://www.youtube.com/watch?v=2J9zsFwhF2Q"), description: "", muscleGroups: "股四頭肌、臀大肌", instructions: "1. 雙腳與肩同寬，腳尖微朝外。\n2. 抬頭挺胸，核心收緊，背部打直。\n3. 臀部像坐椅子一樣向後推，同時下蹲，直到大腿與地面平行。\n4. 過程中保持膝蓋與腳尖方向一致。\n5. 用臀腿力量發力，站回起始位置。", commonMistakes: "1. 膝蓋內夾：在下蹲或站起時，膝蓋向內靠攏，這會對膝關節造成過大壓力。\n2. 駝背或過度拱背：背部沒有保持打直，容易導致下背部受傷。", category: "腿部"))
            .environmentObject(CustomExerciseManager())
    }
}
