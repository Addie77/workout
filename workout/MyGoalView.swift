import SwiftUI

struct MyGoalView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) var dismiss
    
    // Local state to avoid modifying environment object directly during selection
    @State private var localSelectedGoal: GoalSelectionView.Goal
    @State private var localExperience: ActivityLevelView.Experience
    @State private var localFrequency: Int

    init(userData: UserData) {
        _localSelectedGoal = State(initialValue: userData.selectedGoal)
        _localExperience = State(initialValue: userData.experience)
        _localFrequency = State(initialValue: userData.frequency)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("主要健身目標")) {
                    Picker("目標", selection: $localSelectedGoal) {
                        ForEach(GoalSelectionView.Goal.allCases, id: \.self) { goal in
                            Text(goal.rawValue).tag(goal)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("訓練計畫 (經驗等級)")) {
                    Picker("計畫", selection: $localExperience) {
                        ForEach(ActivityLevelView.Experience.allCases, id: \.self) { level in
                            Text(level.rawValue).tag(level)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section(header: Text("每週運動天數")) {
                    Stepper(value: $localFrequency, in: 1...7) {
                        Text("\(localFrequency) 天")
                    }
                }
            }
            .navigationTitle("我的目標")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("儲存") {
                        saveChanges()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
        userData.selectedGoal = localSelectedGoal
        userData.experience = localExperience
        userData.frequency = localFrequency
        userData.saveProfile()
    }
}

struct MyGoalView_Previews: PreviewProvider {
    static var previews: some View {
        // We need to create a UserData instance that can be passed to the init
        let userData = UserData()
        return MyGoalView(userData: userData)
            .environmentObject(userData)
    }
}
