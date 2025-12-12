import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userData: UserData

    @State private var name: String = ""
    @State private var gender: String = "男"
    @State private var height: Double = 170.0
    @State private var weight: Double = 70.0
    @State private var age: Int = 30
    
    let genders = ["男", "女", "其他"]

    var body: some View {
        Form {
            Section(header: Text("個人資料")) {
                TextField("名稱", text: $name)
                
                Picker("性別", selection: $gender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                
                Stepper("身高: \(height, specifier: "%.1f") cm", value: $height, in: 100...250, step: 0.5)
                Stepper("體重: \(weight, specifier: "%.1f") kg", value: $weight, in: 30...200, step: 0.1)
                Stepper("年齡: \(age)", value: $age, in: 10...100)
            }
        }
        .navigationTitle("設定")
        .onAppear {
            if let userProfile = userData.userProfile {
                name = userProfile.name
                gender = userProfile.gender
                height = userProfile.height
                weight = userProfile.weight
                age = userProfile.age
            }
        }
        .onDisappear {
            saveChanges()
        }
    }

    private func saveChanges() {
        if var userProfile = userData.userProfile {
            userProfile.name = name
            userProfile.gender = gender
            userProfile.height = height
            userProfile.weight = weight
            userProfile.age = age
            userData.saveProfile(userProfile)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .environmentObject(UserData())
        }
    }
}