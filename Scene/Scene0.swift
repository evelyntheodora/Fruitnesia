//
//  Scene0.swift
//  salakku
//
//  Created by Evelyn Theodora Siswanto on 16/04/23.
//

import SwiftUI



struct Scene0: View {
    @State private var nextPage = false
    @State private var pageOpacity = 0.0
    @State private var isDelayed: Bool = false
    @State private var isDimmed: Bool = false
    
    var body: some View {

        ZStack {
            Color("backgroundZero")
                .font(.custom("MPLUSRounded1c-Bold", size: 80))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Fruitnesia")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500)
                    .padding(.bottom, 50)
                
                Image("timpa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 500)
                
                if !nextPage {
                    Text("Tap to play")
    //                    .foregroundColor(.gray)
                        .font(.system(size: 50))
                        .fontWeight(.semibold)
                        .padding(.top, 50)
                        .opacity(isDimmed ? 0.7 : 1)
                        .onAppear {
                            startTimer()
                        }
                        .opacity(pageOpacity == 1.0 ? 0.8 : pageOpacity)
                }
            }
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(nextPage ? ContentView() : nil)
        }
        .onTapGesture {
            nextPage = true
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
            withAnimation {
                isDimmed.toggle()
            }
        }
    }
}

extension View {
    func navigationStack() -> some View {
        self
            .edgesIgnoringSafeArea(.all)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

public extension View {
    func opacityEaseIn(using animation: Animation = Animation.easeIn(duration: 1), delayCount: Double, _ action: @escaping () -> Void) -> some View {
        let delay = animation.delay(delayCount)
        
        return onAppear {
            withAnimation(delay) {
                action()
            }
        }
    }
}

struct Scene0_Previews: PreviewProvider {
    static var previews: some View {
        Scene0()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
