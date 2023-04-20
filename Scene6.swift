//
//  Scene6.swift
//  Salakku
//
//  Created by Evelyn Theodora Siswanto on 11/04/23.
//

import SwiftUI

struct Scene6: View {
    @State private var currentIndex: Int = 0
    @State private var isAnimating: Bool = false
    @State private var stackAlignment: VerticalAlignment = .bottom
    @State private var toScene8: Bool = false
    @State private var pageOpacity = 0.0
    @State private var isDelayed: Bool = false
    @State private var isDimmed: Bool = false
    
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            HStack (alignment: stackAlignment) {
                
                if currentIndex == 0 {
                    VStack{}
                        .frame(width: 100)
                    Image("salakShine")
                        .gesture(DragGesture(minimumDistance: 200.0, coordinateSpace: .local).onEnded({ value in
                            print(value.translation)
                            switch(value.translation.width, value.translation.height) {
                            case (-1000...1000, -1000...1000): currentIndex += 1
                            default: print("not this one")
                            }
                            stackAlignment = .center
                            isAnimating = true
                        }))
                    Spacer()
                    VStack (alignment: .trailing) {
                        Text("Let’s try to ")
                        + Text("peel the skin")
                            .fontWeight(.semibold)
                        + Text(" and ")
                        + Text("see how the fruit looks like!")
                        
                        Spacer()
                        Spacer()
                    }
                    .font(.system(size: 48))
                    .foregroundColor(Color("textblack"))
                    .frame(height: 400)
                    //                .background(Color.red)
                    .padding(.leading, 70)
                    VStack{}
                        .frame(width: 100)
                } else {
                    VStack{}
                        .frame(width: 100)
                    Image("salakShine")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(x: -150, y: 50)
                        .rotationEffect(.degrees(-10))
                        .shadow(color: Color("danger").opacity(0.8), radius: 20)
                    Spacer()
                    VStack (alignment: .trailing) {
                        Text("OUCH !!")
                            .foregroundColor(Color("red"))
                            .fontWeight(.semibold)
                            .font(.system(size: 100))
                            .padding(.bottom, 3)
                            .padding(.trailing, 35)
                        Text("The skin has sharp edges")
                        Text("that can hurt your hands")
                    }
                    .font(.system(size: 48))
                    .foregroundColor(Color("textblack"))
                    .frame(width: 550, height: 400)
                    VStack{}
                        .frame(width: 100)
                }
            }
            .frame(maxWidth: .infinity)
            .animation(.easeInOut, value: isAnimating)
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toScene8 ? Scene8() : nil)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isDelayed = true
                }
            }
            
            if (!toScene8 && isDelayed) {
                Text(currentIndex == 0 ? "Slice the Snakefruit to peel the skin" : "Tap to continue")
                    .foregroundColor(.gray)
                    .font(.system(size: 36))
                    .offset(x: currentIndex == 0 ? UIScreen.main.bounds.size.width * 2/9 : UIScreen.main.bounds.size.width*3.4/9, y: UIScreen.main.bounds.size.height * 1 / 5)
                    .opacity(isDimmed ? 0.5 : 1)
                    .onAppear {
                        startTimer()
                    }
                    .opacity(pageOpacity == 1.0 ? 0.8 : pageOpacity)
            }
        }
        .onTapGesture {
            toScene8 = currentIndex == 1 ? true : false
            isDelayed = toScene8 ? false : isDelayed
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


struct Scene6_Previews: PreviewProvider {
    static var previews: some View {
        Scene6()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
