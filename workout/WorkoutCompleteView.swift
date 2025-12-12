//
//  WorkoutCompleteView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI

struct WorkoutCompleteView: View {
    var onDismiss: () -> Void

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
            
            Text("訓練完成！")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 24)
            
            Text("做得好，Alex！繼續保持。")
                .font(.headline)
                .foregroundColor(.gray)

            HStack(spacing: 40) {
                VStack {
                    Text("總時長")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("42:15")
                        .font(.title)
                        .fontWeight(.bold)
                }
                VStack {
                    Text("總消耗 (估)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("315")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 40)

            Spacer()

            Button(action: onDismiss) {
                Text("返回首頁")
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

struct WorkoutCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCompleteView(onDismiss: {})
    }
}
