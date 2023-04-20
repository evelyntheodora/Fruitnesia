//
//  Scene3.swift
//  Salakku
//
//  Created by Evelyn Theodora Siswanto on 11/04/23.
//

import SwiftUI

struct Scene3: View {
    @State private var currentIndex: Int = 0
    @State private var isAnimating: Bool = false
    @State private var toScene5: Bool = false
    @State private var isDimmed: Bool = false
    @State private var pageOpacity = 0.0
    @State private var isDelayed: Bool = false
    
    //    @State private var location: CGPoint = CGPoint(x: 50, y:50)
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Image("salakShine")
                    //                        .animation()
                    if currentIndex >= 1 {
                        VStack (alignment: .trailing) {
                            Text("This is called")
                                .font(.system(size: 48))
                                .foregroundColor(Color("textblack"))
                            HStack{
                                Text("Salak")
                                    .foregroundColor(Color("accent"))
                                Text("in Indonesia")
                            }
                            .font(.system(size: 74))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("textblack"))
                            .padding(.leading, 66)
                            
                        }
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.isDelayed = true
                            }
                        }
                    }       
                }
            }
            .animation(.easeIn, value: isAnimating)
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toScene5 ? Scene5() : nil)
            
            if (isDelayed && !toScene5) {
                Text("Tap to continue")
                    .foregroundColor(.gray)
                    .font(.system(size: 36))
                    .offset(x: UIScreen.main.bounds.size.width * 1 / 3, y: UIScreen.main.bounds.size.height * 1 / 5)
                    .opacity(isDimmed ? 0.5 : 1)
                    .onAppear {
                        startTimer()
                    }
                    .opacity(pageOpacity == 1.0 ? 0.8 : pageOpacity)
            }
        }
        .onTapGesture {
            isDelayed = toScene5 ? false : isDelayed
            self.currentIndex += 1
            toScene5 = currentIndex > 1 ? true : false
            isAnimating = true
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation {
                isDimmed.toggle()
            }
        }
    }
}

struct Scene3_Previews: PreviewProvider {
    static var previews: some View {
        Scene3()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
