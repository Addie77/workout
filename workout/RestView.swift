//
//  RestView.swift
//  workout
//
//  Created by Gemini on 2025/12/13.
//

import SwiftUI
import Combine

struct RestView: View {
    @Binding var isResting: Bool
    @State private var timeRemaining: Int = 60
    let totalTime: Int
    var onFinish: () -> Void
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(isResting: Binding<Bool>, totalTime: Int = 60, onFinish: @escaping () -> Void) {
        self._isResting = isResting
        self.totalTime = totalTime
        self.onFinish = onFinish
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("休息時間")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(timeRemaining) / CGFloat(totalTime))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.blue)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: timeRemaining)
                    
                    Text("\(timeRemaining)")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 250, height: 250)
                .padding()
                
                HStack(spacing: 30) {
                    Button(action: {
                        if timeRemaining > 10 {
                            timeRemaining -= 10
                        } else {
                            timeRemaining = 0
                            finishRest()
                        }
                    }) {
                        VStack {
                            Image(systemName: "gobackward.10")
                                .font(.title)
                            Text("-10s")
                        }
                        .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        finishRest()
                    }) {
                        Text("跳過休息")
                            .font(.headline)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    
                    Button(action: {
                        timeRemaining += 10
                    }) {
                        VStack {
                            Image(systemName: "goforward.10")
                                .font(.title)
                            Text("+10s")
                        }
                        .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
            timeRemaining = totalTime
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                finishRest()
            }
        }
    }
    
    private func finishRest() {
        isResting = false
        onFinish()
    }
}

struct RestView_Previews: PreviewProvider {
    static var previews: some View {
        RestView(isResting: .constant(true), totalTime: 60) {}
    }
}
