import SwiftUI
import PhotosUI

struct CreateExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @State private var exerciseName: String = ""
    @State private var targetMuscleGroup: Int = 0
    @State private var instructions: String = ""
    @State private var commonMistakes: String = ""
    @State private var showAlert: Bool = false
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage? // Keep UIImage for preview
    @State private var selectedImageBase64: String? // Store Base64 string for Exercise model
    
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
                
                Section(header: Text("動作圖片 (可選)")) {
                    VStack {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.largeTitle)
                                .padding()
                                .foregroundColor(.gray)
                        }
                        
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Text(selectedImage == nil ? "上傳圖片" : "更換圖片")
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
                                assetImageName: nil, // Newly created custom exercises will use userImageBase64
                                userImageBase64: selectedImageBase64,
                                videoURL: nil,
                                description: "",
                                muscleGroups: muscleGroups[targetMuscleGroup],
                                instructions: instructions,
                                commonMistakes: commonMistakes,
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
