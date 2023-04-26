//
//  Scene5.swift
//  Salakku
//
//  Created by Evelyn Theodora Siswanto on 11/04/23.
//

import SwiftUI

struct Scene5: View {
    
    @State private var toScene6: Bool = false
    @State private var pageOpacity = 0.0
    @State private var isDimmed: Bool = false
    @State private var isDelayed: Bool = false
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Image("salakZoom")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 580.8)
                    .offset(x: 100)
                
                VStack (alignment: .trailing) {
                    Text("It has ")
                    + Text("brownish scaly skin")
                        .fontWeight(.semibold)
                    + Text(" that looks just like a snake ")
                    + Text("so it is also called ")
                    + Text("Snakefruit")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("accent"))
                }
                .font(.system(size: 48))
                .foregroundColor(Color("textblack"))
                .opacity(pageOpacity)
                .opacityEaseIn(delayCount: 0) {
                    pageOpacity = 1.0
                }
                .navigationStack()
                .overlay(toScene6 ? Scene6() : nil)
            }
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1
            }
            .navigationStack()
            .overlay(toScene6 ? Scene6() : nil)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isDelayed = true
                }
            }
            
            if (isDelayed && !toScene6) {
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
            toScene6 = true
        }
        .navigationTitle("")
        .navigationBarHidden(true)
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

struct Scene5_Previews: PreviewProvider {
    static var previews: some View {
        Scene5()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
