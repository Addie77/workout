//
//  ContentView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete = false

    var body: some View {
        if isOnboardingComplete {
            MainTabView(isOnboardingComplete: $isOnboardingComplete)
        } else {
            OnboardingView(onOnboardingComplete: {
                isOnboardingComplete = true
            })
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserData())
}
