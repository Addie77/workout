//
//  OnboardingView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var userData: UserData
    @State private var currentStep = 0
    
    // This would be passed to the main App view to dismiss the onboarding
    var onOnboardingComplete: () -> Void

    var body: some View {
        NavigationView {
            ZStack {
                switch currentStep {
                case 0:
                    WelcomeView {
                        withAnimation {
                            currentStep = 1
                        }
                    }
                case 1:
                    GoalSelectionView(
                        onNext: { withAnimation { currentStep = 2 } },
                        onBack: { withAnimation { currentStep = 0 } }
                    )
                case 2:
                    UserStatsView(
                        onNext: { withAnimation { currentStep = 3 } },
                        onBack: { withAnimation { currentStep = 1 } }
                    )
                case 3:
                    ActivityLevelView(
                        onComplete: onOnboardingComplete,
                        onBack: { withAnimation { currentStep = 2 } }
                    )
                default:
                    WelcomeView(onStart: {})
                }
            }
            .navigationTitle("")
            .navigationBarHidden(currentStep == 0) // Hide on welcome
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onOnboardingComplete: {})
            .environmentObject(UserData()) // Provide a UserData for preview
    }
}
