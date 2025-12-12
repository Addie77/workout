import SwiftUI

struct ProfileView: View {
    @Binding var isOnboardingComplete: Bool
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @State private var showingDeleteAlert = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ProfileHeaderView()
                    
                    StatsGridView()
                    
                    OptionsListView()
                    
                    // Danger Zone
                    VStack(alignment: .leading) {
                        Text("危險區域")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Button(action: {
                            showingDeleteAlert = true
                        }) {
                            HStack {
                                Image(systemName: "trash.fill")
                                Text("刪除所有自訂動作")
                                Spacer()
                            }
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(20)
                        }
                    }
                    
                    LogoutButton(isOnboardingComplete: $isOnboardingComplete)
                }
                .padding()
            }
            .navigationTitle("個人資料")
            .alert("確定要刪除嗎？", isPresented: $showingDeleteAlert) {
                Button("刪除", role: .destructive) {
                    customExerciseManager.deleteAllExercises()
                }
                Button("取消", role: .cancel) {}
            } message: {
                Text("此操作將會永久刪除您建立的所有自訂動作，且無法復原。")
            }
        }
    }
}

struct ProfileHeaderView: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        HStack(spacing: 20) {
            Image("profile-pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(userData.userProfile?.name ?? "User")
                    .font(.title)
                    .fontWeight(.bold)
                Text("增肌計畫・基礎 (第 1 週)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct StatsGridView: View {
    var body: some View {
        HStack(spacing: 20) {
            StatBox(title: "總訓練次數", value: "1")
            StatBox(title: "目前連續天數", value: "1")
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
    }
}

struct OptionsListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: Text("已完成計畫")) {
                OptionRow(title: "已完成計畫", icon: "⭐", iconColor: .yellow)
            }
            Divider()
            NavigationLink(destination: Text("我的目標")) {
                OptionRow(title: "我的目標", icon: "🎯", iconColor: .blue)
            }
            Divider()
            NavigationLink(destination: Text("設定")) {
                OptionRow(title: "設定", icon: "⚙️", iconColor: .green)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
    }
}

struct OptionRow: View {
    let title: String
    let icon: String
    let iconColor: Color
    
    var body: some View {
        HStack {
            Text(icon)
                .font(.title2)
                .foregroundColor(iconColor)
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct LogoutButton: View {
    @Binding var isOnboardingComplete: Bool
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var showingDeleteAccountAlert = false

    var body: some View {
        Button(action: {
            showingDeleteAccountAlert = true
        }) {
            Text("刪除帳號")
                .font(.headline)
                .foregroundColor(.red)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
        }
        .alert("確定要刪除帳號嗎？", isPresented: $showingDeleteAccountAlert) {
            Button("刪除", role: .destructive) {
                userData.deleteAccount()
                customExerciseManager.deleteAllExercises()
                workoutManager.deleteAllWorkouts()
                isOnboardingComplete = false
            }
            Button("取消", role: .cancel) {}
        } message: {
            Text("此操作將會清除所有個人資料與設定，並回到初始設定畫面。")
        }
    }
}

#Preview {
    ProfileView(isOnboardingComplete: .constant(true))
        .environmentObject(CustomExerciseManager())
        .environmentObject(UserData())
        .environmentObject(WorkoutManager())
}
