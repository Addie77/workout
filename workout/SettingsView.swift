import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userData: UserData
    @State private var newName: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("個人資訊")) {
                TextField("使用者名稱", text: $newName)
            }
        }
        .navigationTitle("設定")
        .navigationBarItems(trailing:
            Button("儲存") {
                if userData.userProfile != nil {
                    userData.userProfile?.name = newName
                    userData.updateAndSaveProfile()
                }
                presentationMode.wrappedValue.dismiss()
            }
        )
        .onAppear {
            newName = userData.userProfile?.name ?? ""
        }
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
    .environmentObject(UserData())
}
