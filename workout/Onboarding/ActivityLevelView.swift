//
//  ActivityLevelView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct ActivityLevelView: View {
    @EnvironmentObject var userData: UserData
    
    var onComplete: () -> Void
    var onBack: () -> Void

    enum Experience: String, CaseIterable {
        case beginner = "新手 (剛開始或少於 6 個月)"
        case intermediate = "中級 (有 6-18 個月經驗)"
        case advanced = "進階 (18 個月以上)"
    }
    
    enum Frequency: String, CaseIterable {
        case twoDays = "2 天"
        case threeDays = "3 天"
        case fourPlusDays = "4+ 天"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("步驟 3 / 3")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.bottom, 4)

            Text("您的健身經驗？")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("這將決定您的起始等級。")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 4)

            // Experience Level
            VStack(spacing: 16) {
                ForEach(Experience.allCases, id: \.self) { level in
                    ExperienceOptionRow(level: level, isSelected: userData.experience == level) {
                        userData.experience = level
                    }
                }
            }
            .padding(.top, 32)
            
            Text("您平均一週運動幾天？")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 32)

            // Frequency
            Picker("您平均一週運動幾天？", selection: $userData.frequency) {
                ForEach(Frequency.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)

            Spacer()

            Button(action: {
                userData.saveProfile() // Create account/Save profile
                onComplete()
            }) {
                Text("生成我的計畫")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
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

struct ExperienceOptionRow: View {
    let level: ActivityLevelView.Experience
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(level.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
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

struct ActivityLevelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActivityLevelView(onComplete: {}, onBack: {})
                .environmentObject(UserData()) // Provide a UserData for preview
        }
    }
}
