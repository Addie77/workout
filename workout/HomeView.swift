//
//  HomeView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userData: UserData
    @Binding var selection: Tab

    var currentWorkout: Workout {
        switch userData.experience {
        case .beginner:
            return ExerciseData.beginnerWorkout
        case .intermediate:

            return ExerciseData.intermediateWorkout
        case .advanced:
            return ExerciseData.advancedWorkout
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading) {
                        Text("您好, \(userData.userProfile?.name ?? "User")")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("您的總覽")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    // Today's Workout Card
                    NavigationLink(destination: WorkoutDetailView(workout: currentWorkout)) {
                        TodaysWorkoutCard(workout: currentWorkout)
                    }
                    
                    // Weekly Progress
                    WeeklyProgressCard(userData: userData)
                    
                    // Explore
                    ExploreCard(selection: $selection)

                }
                .padding()
            }
            .navigationTitle("總覽")
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

struct TodaysWorkoutCard: View {
    let workout: Workout
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("今日訓練")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(workout.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(" (\(workout.level))")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.8))
            }

            Text(workout.description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Text("開始訓練")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(20)
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(25)
        .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
    }
}

struct WeeklyProgressCard: View {
    @ObservedObject var userData: UserData

    private var workoutsThisWeek: [WorkoutLog] {
        let startOfWeek = Date.getStartOfWeek()
        return userData.workoutLogs.filter { $0.date >= startOfWeek }
    }

    private var targetWorkouts: Int {
        switch userData.frequency {
        case .twoDays: return 2
        case .threeDays: return 3
        case .fourPlusDays: return 4
        }
    }

    private var progress: Double {
        guard targetWorkouts > 0 else { return 0 }
        return min(Double(workoutsThisWeek.count) / Double(targetWorkouts), 1.0)
    }

    private var days: [String] {
        ["一", "二", "三", "四", "五", "六", "日"]
    }
    
    private func isDayCompleted(_ dayIndex: Int) -> Bool {
        // Check if there is any log for the given day index
        workoutsThisWeek.contains { log in
            log.date.getWeekday() == dayIndex
        }
    }

    private func isToday(_ dayIndex: Int) -> Bool {
        Date().getWeekday() == dayIndex
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("本週進度")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            VStack(spacing: 12) {
                HStack {
                    Text("已完成 \(workoutsThisWeek.count) / \(targetWorkouts) 次訓練")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(Int(progress * 100))%")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                
                HStack(spacing: 12) {
                    ForEach(0..<days.count, id: \.self) { index in
                        DayView(day: days[index],
                                isCompleted: isDayCompleted(index),
                                isToday: isToday(index))
                    }
                }
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(20)
        }
    }
}

struct DayView: View {
    let day: String
    let isCompleted: Bool
    let isToday: Bool
    var isFutureWorkout: Bool = false
    
    var body: some View {
        VStack {
            Text(day)
                .font(.caption)
                .foregroundColor(isToday ? .primary : .secondary)
            
            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
            } else if isToday {
                 Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 30, height: 30)
                    .background(Circle().fill(Color.blue.opacity(0.2)))
            } else if isFutureWorkout {
                Circle()
                   .stroke(Color.blue, lineWidth: 2)
                   .frame(width: 30, height: 30)
                   .background(Circle().fill(Color.blue.opacity(0.2)))
            }
            else {
                Circle()
                    .fill(Color(UIColor.systemGray5))
                    .frame(width: 30, height: 30)
            }
        }
    }
}


struct ExploreCard: View {
    @Binding var selection: Tab

    var body: some View {
        VStack(alignment: .leading) {
            Text("探索動作")
                .font(.title2)
                .fontWeight(.bold)
            Button(action: {
                selection = .explore
            }) {
                Image("explore-banner") // Placeholder for an actual image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .clear]), startPoint: .bottom, endPoint: .center)
                            VStack {
                                Spacer()
                                Text("查看所有動作")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    )
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selection: .constant(.home))
            .environmentObject(UserData()) // Provide a UserData for preview
    }
}
