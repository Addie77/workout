//
//  WorkoutCompleteView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct WorkoutCompleteView: View {
    let workout: Workout
    let duration: TimeInterval
    var onDismiss: () -> Void

    @EnvironmentObject var userData: UserData

    private var durationString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? "00:00"
    }

    private var adjustedCalories: Int {
        guard workout.duration > 0 else { return Int(workout.calories) }
        let ratio = duration / workout.duration
        return Int(workout.calories * ratio)
    }

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
            
            Text("訓練完成！")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 24)
            
            Text("做得好，\(userData.userProfile?.name ?? "User")！繼續保持。")
                .font(.headline)
                .foregroundColor(.gray)

            HStack(spacing: 40) {
                VStack {
                    Text("總時長")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(durationString)
                        .font(.title)
                        .fontWeight(.bold)
                }
                VStack {
                    Text("總消耗 (估)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("\(adjustedCalories)")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 40)

            Spacer()

            Button(action: onDismiss) {
                Text("返回首頁")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 60)
        }
    }
}

struct WorkoutCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCompleteView(workout: ExerciseData.beginnerWorkout, duration: 2535, onDismiss: {})
            .environmentObject(UserData())
    }
}
