//
//  Scene18.swift
//  salakku
//
//  Created by Evelyn Theodora Siswanto on 12/04/23.
//

import SwiftUI

struct Scene18: View {
    @State private var currentIndex: Int = 0
    @State private var isAnimating: Bool = false
    @State private var pageOpacity = 0.0
    @State private var toCardView: Bool = false
    @State private var isDelayed: Bool = false
    @State private var isDimmed: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 60) {
                Image(chooseImage(currentIndex: currentIndex))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 400)
                
                VStack (spacing: 10) {
//                    if currentIndex == 0 {
//                        Text("")
//                        Text("")
//                    } else
                if currentIndex == 0 {
                        Text("We did it!")
                            .foregroundColor(Color("green"))
                            .fontWeight(.semibold)
                        Text("We managed to peel the skin")
                    } else if currentIndex == 1 {
                        HStack {
                            Text("Why don't you try")
                            Text("a bite?")
                                .fontWeight(.semibold)
                        }
                        HStack {
                            Text("Let's")
                            Text("eat")
                                .foregroundColor(Color("accent"))
                                .fontWeight(.semibold)
                            Text("this Snakefruit")
                        }
                    } else if currentIndex >= 2 && currentIndex < 6 {
                        Text("Tap to eat the Snakefruit")
                            .opacity(isDimmed ? 0.5 : 1)
                            .onAppear {
                                startTimer()
                            }
                            .opacity(pageOpacity == 1.0 ? 0.8 : pageOpacity)
                    } else if currentIndex == 7 {
                        HStack {
                            Text("You")
                            Text("found")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("green"))
                            Text("the seed!")
                        }
                        Text("Tap to collect the seed")
                            .font(.system(size: 40))
                            .opacity(isDimmed ? 0.8 : 1)
                            .onAppear {
                                startTimer()
                            }
                            .opacity(pageOpacity == 1.0 ? 0.8 : pageOpacity)
                        
                    } else if currentIndex == 8 {
                    }
                }
                .font(.system(size: 48))
                .frame(height: 100)
                
            }
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0.2) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toCardView ? CardView() : nil)
        }
        .onTapGesture {
            if self.currentIndex < 7 {
                self.currentIndex += 1
            } else {
                toCardView = true
            }
            isAnimating = true
            print(currentIndex)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
    
    func chooseImage(currentIndex: Int) -> String {
        if currentIndex < 3 {
            return "meatPNG"
        } else if currentIndex == 3 {
            return "munch1"
        } else if currentIndex == 4 {
            return "munch2"
        } else if currentIndex == 5 {
            return "munch3"
        } else if currentIndex == 6 {
            return "munch4"
        } else {
            return "seedGlow"
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
            withAnimation {
                isDimmed.toggle()
            }
        }
    }
}


struct Scene18_Previews: PreviewProvider {
    static var previews: some View {
        Scene18()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
