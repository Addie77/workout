//
//  GoalSelectionView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct GoalSelectionView: View {
    @EnvironmentObject var userData: UserData
    var onNext: () -> Void
    var onBack: () -> Void

    enum Goal: String, CaseIterable {
        case fatLoss = "燃燒脂肪"
        case strength = "增強肌力"
        case health = "保持健康"

        var emoji: String {
            switch self {
            case .fatLoss: return "🔥"
            case .strength: return "💪"
            case .health: return "🤸"
            }
        }

        var description: String {
            switch self {
            case .fatLoss: return "以減脂和提升體能為主。"
            case .strength: return "建立肌肉量與力量。"
            case .health: return "維持活動力與身體機能。"
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            Text("步驟 1 / 3")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.bottom, 4)

            Text("您的主要健身目標？")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("這將幫助我們為您量身定制計畫。")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 4)

            // Options
            VStack(spacing: 16) {
                ForEach(Goal.allCases, id: \.self) { goal in
                    GoalOptionRow(goal: goal, isSelected: userData.selectedGoal == goal) {
                        userData.selectedGoal = goal
                    }
                }
            }
            .padding(.top, 32)
            
            Spacer()

            // Footer
            Button(action: onNext) {
                Text("下一步")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 60)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: onBack) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("返回")
                    }
                }
            }
        }
    }
}

struct GoalOptionRow: View {
    let goal: GoalSelectionView.Goal
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(goal.emoji)
                    .font(.largeTitle)
                VStack(alignment: .leading) {
                    Text(goal.rawValue)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Text(goal.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color(UIColor.systemGray6))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
    }
}


struct GoalSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalSelectionView(onNext: {}, onBack: {})
                .environmentObject(UserData())
        }
    }
}
