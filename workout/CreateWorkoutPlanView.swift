import SwiftUI

struct CreateWorkoutPlanView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    
    @State private var planName: String = ""
    @State private var selectedExercises: [Exercise] = []
    @State private var searchText: String = ""
    @State private var showingAddExercise = false
    
    private var allExercises: [Exercise] {
        ExerciseData.allExercises + customExerciseManager.customExercises
    }
    
    private var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return allExercises
        } else {
            return allExercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("計畫名稱")) {
                        TextField("請輸入計畫名稱", text: $planName)
                    }
                    
                    Section(header: Text("已選動作")) {
                        ForEach(selectedExercises) { exercise in
                            Text(exercise.name)
                        }
                        .onMove(perform: move)
                        
                        Button(action: {
                            showingAddExercise.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("新增動作")
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingAddExercise) {
                    AddExerciseToPlanView(selectedExercises: $selectedExercises)
                }
            }
            .navigationTitle("建立新計畫")
            .navigationBarItems(leading: Button("取消") {
                dismiss()
            }, trailing: Button("儲存") {
                savePlan()
                dismiss()
            })
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        selectedExercises.move(fromOffsets: source, toOffset: destination)
    }
    
    private func savePlan() {
        let newWorkout = Workout(
            name: planName,
            description: "", // Or some default
            duration: 0, // Will be calculated
            calories: 0, // Will be calculated
            level: "自訂",
            exercises: selectedExercises
        )
        workoutManager.addWorkout(newWorkout)
    }
}

struct AddExerciseToPlanView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @Binding var selectedExercises: [Exercise]
    
    @State private var searchText: String = ""
    
    private var allExercises: [Exercise] {
        ExerciseData.allExercises + customExerciseManager.customExercises
    }
    
    private var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return allExercises
        } else {
            return allExercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(filteredExercises) { exercise in
                    Button(action: {
                        if !selectedExercises.contains(where: { $0.id == exercise.id }) {
                            selectedExercises.append(exercise)
                        }
                    }) {
                        Text(exercise.name)
                    }
                }
            }
            .navigationTitle("新增動作")
            .navigationBarItems(trailing: Button("完成") {
                dismiss()
            })
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("搜尋...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
        .padding(.horizontal, 10)
    }
}

struct CreateWorkoutPlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutPlanView()
            .environmentObject(WorkoutManager())
            .environmentObject(CustomExerciseManager())
    }
}

struct AddExerciseToPlanView_Previews: PreviewProvider {
    @State static var exercises: [Exercise] = []
    
    static var previews: some View {
        AddExerciseToPlanView(selectedExercises: $exercises)
            .environmentObject(CustomExerciseManager())
    }
}
