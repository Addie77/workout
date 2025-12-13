import SwiftUI

struct CompletedWorkoutsView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var workoutManager: WorkoutManager

    // Sort logs with newest first
    private var sortedLogs: [WorkoutLog] {
        userData.workoutLogs.sorted { $0.date > $1.date }
    }

    var body: some View {
        NavigationView {
            VStack {
                if sortedLogs.isEmpty {
                    Text("您尚未完成任何訓練。")
                        .foregroundColor(.secondary)
                        .frame(maxHeight: .infinity)
                } else {
                    List(sortedLogs) { log in
                        WorkoutLogRow(log: log, workoutManager: workoutManager)
                    }
                }
            }
            .navigationTitle("已完成計畫")
        }
    }
}

struct WorkoutLogRow: View {
    let log: WorkoutLog
    let workoutManager: WorkoutManager

    private var workoutName: String {
        // Find the workout name from both default and custom workouts
        let allWorkouts = workoutManager.workouts + [ExerciseData.beginnerWorkout, ExerciseData.intermediateWorkout, ExerciseData.advancedWorkout]
        return allWorkouts.first { $0.id == log.workoutId }?.name ?? "未知訓練"
    }

    private var durationString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: log.duration) ?? ""
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workoutName)
                .font(.headline)
            
            HStack {
                Text(log.date, style: .date)
                Spacer()
                Label(durationString, systemImage: "clock")
                Spacer()
                Label("\(Int(log.caloriesBurned)) 卡", systemImage: "flame.fill")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct CompletedWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        let workoutManager = WorkoutManager()
        
        let sampleWorkout = ExerciseData.beginnerWorkout
        workoutManager.addWorkout(sampleWorkout)
        userData.logWorkout(workout: sampleWorkout, duration: 2700)

        return CompletedWorkoutsView()
            .environmentObject(userData)
            .environmentObject(workoutManager)
    }
}
