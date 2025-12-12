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
                    .padding()
                    .frame(maxWidth: .infinity)
                } else {
                    List {
                        ForEach(workoutManager.workouts) { workout in
                            NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                WorkoutRow(workout: workout)
                            }
                        }
                        .onDelete(perform: deleteWorkout)
                    }
                }
            }
            .navigationTitle("計畫")
            .toolbar {
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

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.name)
                    .font(.headline)
                Text("\(workout.exercises.count) 個動作")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
            .environmentObject(WorkoutManager())
    }
}
