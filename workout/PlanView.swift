import SwiftUI

struct PlanView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var showingCreateWorkoutPlanView = false
    // Removed @Environment(\.editMode) private var editMode
    // Removed @State private var selection = Set<UUID>()
    
    // State for editing a workout
    @State private var workoutToEdit: Workout?
    @State private var showingRenameSheet = false
    @State private var showingEditExercisesSheet = false

    var body: some View {
        NavigationView {
            VStack {
                // No top-of-view delete button
                
                if workoutManager.workouts.isEmpty {
                    VStack {
                        Text("您尚未建立任何計畫。")
                            .foregroundColor(.secondary)
                        Text("點擊右上角的 + 來新增一個吧！")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity) // Pushes to center
                } else {
                    List { // Removed (selection: $selection)
                        ForEach(workoutManager.workouts) { workout in
                            HStack {
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    WorkoutRow(workout: workout)
                                }
                                
                                // Menu appears always now
                                // No conditional for editMode
                                Spacer()
                                Menu {
                                    Button("重新命名") {
                                        workoutToEdit = workout
                                        showingRenameSheet = true
                                    }
                                    Button("編輯/新增動作") {
                                        workoutToEdit = workout
                                        showingEditExercisesSheet = true
                                    }
                                    // Add Delete button
                                    Button("刪除", role: .destructive) {
                                        deleteWorkout(workout: workout)
                                    }
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                        .font(.title2)
                                        .padding(10) // Increase tappable area
                                }
                                .foregroundColor(.accentColor)
                            }
                            .padding(.vertical, 4)
                        }
                        // Removed .onDelete(perform: deleteWorkout)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .animation(.default, value: UUID()) // Animation value will just be a dummy UUID now
            .navigationTitle("計畫")
            .toolbar {
                // Removed ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCreateWorkoutPlanView.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateWorkoutPlanView) { CreateWorkoutPlanView() }
            .sheet(isPresented: $showingRenameSheet) {
                if let workout = workoutToEdit {
                    RenameWorkoutView(workout: workout)
                }
            }
            .sheet(isPresented: $showingEditExercisesSheet) {
                if let workout = workoutToEdit {
                    EditWorkoutExercisesView(workout: workout)
                }
            }
        }
    }
    
    // New deleteWorkout method
    private func deleteWorkout(workout: Workout) {
        workoutManager.deleteWorkout(workout: workout)
    }
    
    // Removed old deleteWorkout(at offsets: IndexSet)
}

// Simplified WorkoutRow, as layout is handled in the List
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
