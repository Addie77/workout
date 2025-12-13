import SwiftUI

struct PlanView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var showingCreateWorkoutPlanView = false

    var body: some View {
        NavigationView {
            VStack {
                if workoutManager.workouts.isEmpty {
                    VStack {
                        Text("您尚未建立任何計畫。")
                            .foregroundColor(.secondary)
                        Text("點擊右上角的 + 來新增一個吧！")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(workoutManager.workouts) { workout in
                            NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                WorkoutRow(workout: workout)
                            }
                        }
                        .onDelete(perform: deleteWorkout)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("計畫")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingCreateWorkoutPlanView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateWorkoutPlanView) {
                CreateWorkoutPlanView()
            }
        }
    }
    
    private func deleteWorkout(at offsets: IndexSet) {
        workoutManager.deleteWorkout(at: offsets)
    }
}

// WorkoutRow is now a simple view again.
struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.name)
                .font(.headline)
            Text("\(workout.exercises.count) 個動作")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = WorkoutManager()
        manager.addWorkout(Workout(id: UUID(), name: "Sample Workout", description: "A test workout", duration: 3600, calories: 300, level: "Intermediate", exercises: []))
        return PlanView()
            .environmentObject(manager)
    }
}
