import SwiftUI
import PhotosUI

struct EditExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    
    @State private var exerciseName: String
    @State private var targetMuscleGroup: Int
    @State private var instructions: String
    @State private var commonMistakes: String
    @State private var showAlert: Bool = false
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage? // For previewing selected image
    @State private var selectedImageBase64: String? // Store Base64 string for Exercise model
    
    let exercise: Exercise
    let muscleGroups = ["腿部", "胸部", "背部", "手臂", "核心", "其他"]

    init(exercise: Exercise) {
        self.exercise = exercise
        _exerciseName = State(initialValue: exercise.name)
        _instructions = State(initialValue: exercise.instructions)
        _commonMistakes = State(initialValue: exercise.commonMistakes)
        _selectedImageBase64 = State(initialValue: exercise.userImageBase64)
        
        // Load initial image for preview if it exists
        if let base64String = exercise.userImageBase64,
           let data = Data(base64Encoded: base64String),
           let uiImage = UIImage(data: data) {
            _selectedImage = State(initialValue: uiImage)
        }
        
        let groups = ["腿部", "胸部", "背部", "手臂", "核心", "其他"]
        if let index = groups.firstIndex(of: exercise.muscleGroups) {
             _targetMuscleGroup = State(initialValue: index)
        } else {
             _targetMuscleGroup = State(initialValue: 0)
        }
    }

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
                
                Section(header: Text("動作圖片 (可選)")) {
                    VStack {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        } else {
                            // Show existing image if available and no new image selected
                            if exercise.userImageBase64 != nil || exercise.assetImageName != nil {
                                ExerciseImageView(assetImageName: exercise.assetImageName, userImageBase64: exercise.userImageBase64)
                                    .frame(height: 200)
                                    .cornerRadius(10)
                            } else {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.largeTitle)
                                    .padding()
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Text(selectedImage == nil && (exercise.userImageBase64 == nil && exercise.assetImageName == nil) ? "上傳圖片" : "更換圖片")
                                .font(.headline)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImage = UIImage(data: data)
                                    selectedImageBase64 = data.base64EncodedString()
                                } else {
                                    selectedImage = nil
                                    selectedImageBase64 = nil
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("動作指引")) {
                    TextEditor(text: $instructions)
                        .frame(height: 100)
                }
                
                Section(header: Text("常見錯誤")) {
                    TextEditor(text: $commonMistakes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("編輯動作")
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
                            let updatedExercise = Exercise(
                                id: exercise.id,
                                name: exerciseName,
                                assetImageName: exercise.assetImageName, // Keep original asset name if it exists
                                userImageBase64: selectedImageBase64, // Use newly selected or existing base64
                                videoURL: exercise.videoURL,
                                description: "",
                                muscleGroups: muscleGroups[targetMuscleGroup],
                                instructions: instructions,
                                commonMistakes: commonMistakes,
                                category: muscleGroups[targetMuscleGroup]
                            )
                            customExerciseManager.updateExercise(updatedExercise)
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
    EditExerciseView(exercise: Exercise(name: "My Custom Exercise", assetImageName: nil, userImageBase64: nil, videoURL: nil, description: "My notes", muscleGroups: "胸部", instructions: "Step 1...", commonMistakes: "Don't do this...", category: "胸部"))
        .environmentObject(CustomExerciseManager())
}