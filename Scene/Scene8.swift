//
//  Scene8.swift
//  Salakku
//
//  Created by Evelyn Theodora Siswanto on 11/04/23.
//

import SwiftUI

struct Scene8: View {
    
    @State private var toScene9: Bool = false
    @State private var pageOpacity = 0.0
    @State private var isDimmed: Bool = false
    @State private var isDelayed: Bool = false
    
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            HStack{
                Image("salakShine")
                VStack (alignment: .trailing) {
                    Text("Let’s try to peel it")
                    Text("in a safer way!")
                        .fontWeight(.semibold)
                        .font(.system(size: 74))
                        .foregroundColor(Color("green"))
                    
                }
                .font(.system(size: 48))
                .foregroundColor(Color("textblack"))
                .padding(.leading, 170)
            }
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toScene9 ? Scene9() : nil)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isDelayed = true
                }
            }
            
            if (!toScene9 && isDelayed) {
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
            toScene9 = true
            isDelayed = toScene9 ? false : isDelayed
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation {
                isDimmed.toggle()
            }
        }
    }
}

struct Scene8_Previews: PreviewProvider {
    static var previews: some View {
        Scene8()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
