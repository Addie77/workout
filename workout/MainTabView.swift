//
//  MainTabView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct MainTabView: View {
    @Binding var isOnboardingComplete: Bool

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首頁", systemImage: "house.fill")
                }

            PlanView()
                .tabItem {
                    Label("計畫", systemImage: "calendar")
                }

            ExploreView()
                .tabItem {
                    Label("探索", systemImage: "magnifyingglass")
                }

            ProfileView(isOnboardingComplete: $isOnboardingComplete)
                .tabItem {
                    Label("個人", systemImage: "person.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(isOnboardingComplete: .constant(true))
            .environmentObject(CustomExerciseManager())
            .environmentObject(WorkoutManager())
    }
}
