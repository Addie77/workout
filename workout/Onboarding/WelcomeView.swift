//
//  WelcomeView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct WelcomeView: View {
    var onStart: () -> Void

    var body: some View {
        VStack {
            Spacer()
            
            Text("歡迎使用 健身好夥伴")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("您的個人化健身夥伴。\n讓我們開始打造您的專屬計畫。" ) // Corrected newline escape
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            
            Spacer()
            Spacer()
            
            Button(action: onStart) {
                Text("開始")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 60)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(onStart: {})
    }
}

