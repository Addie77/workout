//
//  MainTabView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

enum Tab {
    case home
    case plan
    case explore
    case profile
}

struct MainTabView: View {
    @Binding var isOnboardingComplete: Bool
    
    @State private var selection: Tab = .home
    @State private var homeStackId = UUID()
    @State private var planStackId = UUID()
    @State private var exploreStackId = UUID()
    @State private var profileStackId = UUID()

    private var tabSelection: Binding<Tab> {
        Binding {
            selection
        } set: { tappedTab in
            // Always reset the stack of the tab that was tapped.
            switch tappedTab {
            case .home:
                homeStackId = UUID()
            case .plan:
                planStackId = UUID()
            case .explore:
                exploreStackId = UUID()
            case .profile:
                profileStackId = UUID()
            }
            
            // And then update the selection.
            selection = tappedTab
        }
    }

    var body: some View {
        TabView(selection: tabSelection) {
            HomeView(selection: $selection)
                .id(homeStackId)
                .tabItem {
                    Label("首頁", systemImage: "house.fill")
                }
                .tag(Tab.home)

            PlanView()
                .id(planStackId)
                .tabItem {
                    Label("計畫", systemImage: "calendar")
                }
                .tag(Tab.plan)

            ExploreView()
                .id(exploreStackId)
                .tabItem {
                    Label("探索", systemImage: "magnifyingglass")
                }
                .tag(Tab.explore)

            ProfileView(isOnboardingComplete: $isOnboardingComplete)
                .id(profileStackId)
                .tabItem {
                    Label("個人", systemImage: "person.fill")
                }
                .tag(Tab.profile)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(isOnboardingComplete: .constant(true))
            .environmentObject(CustomExerciseManager())
            .environmentObject(WorkoutManager())
            .environmentObject(UserData())
    }
}
