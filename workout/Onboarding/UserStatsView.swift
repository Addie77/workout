//
//  UserStatsView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct UserStatsView: View {
    @EnvironmentObject var userData: UserData
    
    var onNext: () -> Void
    var onBack: () -> Void

    enum Gender: String, CaseIterable {
        case male = "男性"
        case female = "女性"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("步驟 2 / 3")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.bottom, 4)

            Text("關於您")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 24)

            ScrollView {
                VStack(spacing: 24) {
                    // Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("姓名")
                            .font(.headline)
                        TextField("請輸入您的姓名", text: $userData.name)
                            .font(.title3)
                            .padding(12)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                    }
                    
                    // Gender
                    VStack(alignment: .leading, spacing: 8) {
                        Text("性別")
                            .font(.headline)
                        Picker("性別", selection: $userData.gender) {
                            ForEach(Gender.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    // Height
                    StatInputView(label: "身高", value: $userData.height, unit: "cm")
                    
                    // Weight
                    StatInputView(label: "體重", value: $userData.weight, unit: "kg")

                    // Age
                    StatInputView(label: "年齡", value: $userData.age, unit: "歲")
                }
            }
            
            Spacer()

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

struct StatInputView: View {
    let label: String
    @Binding var value: String
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.headline)
            HStack {
                TextField("", text: $value)
                    .font(.title3)
                    .padding(12)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                Text(unit)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserStatsView(onNext: {}, onBack: {})
                .environmentObject(UserData())
        }
    }
}
