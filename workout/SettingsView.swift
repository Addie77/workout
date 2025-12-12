import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userData: UserData
    @State private var newName: String = ""
    @State private var newGender: UserStatsView.Gender = .male // Default
    @State private var newHeight: String = ""
    @State private var newWeight: String = ""
    @State private var newAge: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("個人資訊")) {
                TextField("使用者名稱", text: $newName)
                
                Picker("性別", selection: $newGender) {
                    ForEach(UserStatsView.Gender.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    TextField("身高", text: $newHeight)
                        .keyboardType(.decimalPad)
                    Text("cm")
                }
                
                HStack {
                    TextField("體重", text: $newWeight)
                        .keyboardType(.decimalPad)
                    Text("kg")
                }
                
                HStack {
                    TextField("年齡", text: $newAge)
                        .keyboardType(.numberPad)
                    Text("歲")
                }
            }
        }
        .navigationTitle("設定")
        .navigationBarItems(trailing:
            Button("儲存") {
                if userData.userProfile != nil {
                    userData.userProfile?.name = newName
                    userData.userProfile?.gender = newGender.rawValue
                    userData.userProfile?.height = Double(newHeight) ?? 0.0
                    userData.userProfile?.weight = Double(newWeight) ?? 0.0
                    userData.userProfile?.age = Int(newAge) ?? 0
                    userData.updateAndSaveProfile()
                }
                presentationMode.wrappedValue.dismiss()
            }
        )
        .onAppear {
            newName = userData.userProfile?.name ?? ""
            newGender = UserStatsView.Gender(rawValue: userData.userProfile?.gender ?? "男性") ?? .male
            newHeight = String(format: "%.0f", userData.userProfile?.height ?? 0.0)
            newWeight = String(format: "%.1f", userData.userProfile?.weight ?? 0.0)
            newAge = String(userData.userProfile?.age ?? 0)
        }
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
    .environmentObject(UserData())
}
