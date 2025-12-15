import SwiftUI

struct CreateExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @State private var exerciseName: String = ""
    @State private var targetMuscleGroup: Int = 0
    @State private var notes: String = ""
    @State private var showAlert: Bool = false
    
    let muscleGroups = ["腿部", "胸部", "背部", "手臂", "核心", "其他"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("動作資訊")) {
                    TextField("動作名稱 (例如：六角槓硬舉)", text: $exerciseName)
                    
                    Picker("主要目標部位", selection: $targetMuscleGroup) {
                        ForEach(0..<muscleGroups.count, id: \.self) {
                            Text(self.muscleGroups[$0])
                        }
                    }
                }
                
                Section(header: Text("動作教學 (可選)")) {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .padding()
                        Text("上傳圖片或影片")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }
                
                Section(header: Text("個人筆記 (可選)")) {
                    TextEditor(text: $notes)
                        .frame(height: 150)
                }
            }
            .navigationTitle("建立新動作")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("儲存") {
                        if exerciseName.isEmpty {
                            showAlert = true
                        } else {
                            let newExercise = Exercise(
                                name: exerciseName,
                                img: "",
                                videoURL: nil,
                                description: notes,
                                muscleGroups: muscleGroups[targetMuscleGroup],
                                instructions: "", // Or some default
                                commonMistakes: "", // Or some default
                                category: muscleGroups[targetMuscleGroup]
                            )
                            customExerciseManager.addExercise(newExercise)
                            dismiss()
                        }
                    }
                }
            }
            .alert("你需要輸入動作名稱", isPresented: $showAlert) {
                Button("確定", role: .cancel) { }
            }
        }
    }
}

#Preview {
    CreateExerciseView()
        .environmentObject(CustomExerciseManager())
}
