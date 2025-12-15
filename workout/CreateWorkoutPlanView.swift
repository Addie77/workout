import SwiftUI

struct CreateWorkoutPlanView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    
    @State private var planName: String = ""
    @State private var selectedExercises: [WorkoutExercise] = []
    @State private var showingAddExercise = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("計畫名稱")) {
                        TextField("請輸入計畫名稱", text: $planName)
                    }
                    
                    Section(header: Text("已選動作")) {
                        ForEach($selectedExercises) { $workoutExercise in
                            VStack(alignment: .leading) {
                                Text(workoutExercise.exercise.name)
                                HStack {
                                    Stepper("\(workoutExercise.sets) 組", value: $workoutExercise.sets, in: 1...20)
                                    TextField("次數", text: $workoutExercise.reps)
                                        .frame(width: 80)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                            }
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
        let setTime: TimeInterval = 30 // seconds
        let restTime: TimeInterval = 60 // seconds
        let caloriesPerSet: Double = 5 // calories

        let totalSets = selectedExercises.reduce(0) { $0 + $1.sets }
        let totalDuration = TimeInterval(totalSets) * (setTime + restTime)
        let totalCalories = Double(totalSets) * caloriesPerSet

        let newWorkout = Workout(
            name: planName,
            description: "自訂訓練計畫",
            duration: totalDuration,
            calories: totalCalories,
            level: "自訂",
            exercises: selectedExercises
        )
        workoutManager.addWorkout(newWorkout)
    }
}

struct AddExerciseToPlanView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @Binding var selectedExercises: [WorkoutExercise]
    
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
                        if !selectedExercises.contains(where: { $0.exercise.id == exercise.id }) {
                            let workoutExercise = WorkoutExercise(exercise: exercise, sets: 3, reps: "10 次")
                            selectedExercises.append(workoutExercise)
                            dismiss()
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
    @State static var exercises: [WorkoutExercise] = []
    
    static var previews: some View {
        AddExerciseToPlanView(selectedExercises: $exercises)
            .environmentObject(CustomExerciseManager())
    }
}
