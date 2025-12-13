import SwiftUI

struct PlanView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var showingCreateWorkoutPlanView = false
    @Environment(\.editMode) private var editMode
    @State private var selection = Set<UUID>()
    
    // State for editing a workout
    @State private var workoutToEdit: Workout?
    @State private var showingRenameSheet = false
    @State private var showingEditExercisesSheet = false

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
                    .frame(maxHeight: .infinity)
                } else {
                    List(selection: $selection) {
                        ForEach(workoutManager.workouts) { workout in
                            HStack {
                                // Content for navigation
                                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                    WorkoutRow(workout: workout)
                                }
                                
                                // Menu appears only when not in edit mode
                                if editMode?.wrappedValue != .active {
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
                                    } label: {
                                        Image(systemName: "ellipsis.circle")
                                            .font(.title2)
                                            .padding(10) // Increase tappable area
                                    }
                                    .foregroundColor(.accentColor)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(InsetGroupedListStyle()) // Moved here
                }

                // Relocated Delete Button - using .opacity for reliability
                Button(role: .destructive, action: deleteSelectedWorkouts) {
                    Text("刪除 (\(selection.count))")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .disabled(selection.isEmpty || editMode?.wrappedValue.isEditing == false)
                .opacity(editMode?.wrappedValue.isEditing == true ? 1 : 0)
                .background(Color(UIColor.systemBackground))
            }
            .navigationTitle("計畫")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { EditButton() }
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
    
    private func deleteSelectedWorkouts() {
        workoutManager.deleteWorkouts(ids: selection)
        selection.removeAll()
    }
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
