//
//  Scene9.swift
//  salakku
//
//  Created by Evelyn Theodora Siswanto on 12/04/23.
//

import SwiftUI

struct Scene9: View {
    @State private var isEnded: Bool = false
    @State private var location: CGPoint = CGPoint(x: 1200, y: 150)
    @State private var isPlacedCorrectly: Bool = false
    
    @State private var currentIndex: Int = 0
    @State private var isAnimating: Bool = false
    @State private var isTapped: Bool = false
    @State private var hideSalak: Bool = false
    @State private var isLongPressed: Bool = false
    
    @State private var toScene14: Bool = false
    @State private var pageOpacity = 0.0
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged ({ value in
                isEnded = false
                self.location = value.location
                print(value.location)
                if value.location.x > 540 && value.location.x < 960 && value.location.y > 300 && value.location.y <= 550 {
                    self.isPlacedCorrectly = true
                }
            })
            .onEnded({ value in
                if isPlacedCorrectly {
                    self.location = CGPoint(x: UIScreen.main.bounds.size.width * 1 / 2, y: UIScreen.main.bounds.size.height * 1 / 3)
//                    self.location = CGPoint(x: 710, y: 400)
                } else {
                    self.location = CGPoint(x: 1200, y: 150)
                }
                isEnded = true
            })
    }
    
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            Image(!isLongPressed ? openOrClosedHand() : "openHand")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: isTapped && isPlacedCorrectly && isEnded ? 500 : 800)
                .padding(.bottom, 100)
            
            VStack {
                if !hideSalak  {
                    HStack {
                        Spacer()
                        
                        Image(replaceSalak())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180)
                            .padding(.top, 80)
                            .padding(.trailing, 80)
                            .position(location)
                            .gesture(simpleDrag)
                    }
                    
                }
                
                Spacer()
                
                if isPlacedCorrectly && isEnded {
                    HStack {
                        
                        if !isLongPressed {
                            Text("Tap and Hold")
                                .fontWeight(.semibold)
                            Text("to crack the snakefruit skin")
                        }
                    }
                    .font(.system(size: 48))
                } else {
                    HStack {
                        Text("Drag")
                            .fontWeight(.semibold)
                        Text("the Snakefruit to your palm")
                    }
                    .font(.system(size: 48))
                }
            }
            .padding(.bottom, 150)
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toScene14 ? Scene14() : nil)
        }
        .onLongPressGesture(minimumDuration: 1.5, maximumDistance: 100) {
            isLongPressed = true
        } onPressingChanged: { _ in
            isTapped.toggle()
            if isPlacedCorrectly && isEnded {
                hideSalak.toggle()
            }
            toScene14 = isLongPressed ? true : false
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
    
    func openOrClosedHand() -> String {
        if isTapped && isPlacedCorrectly && isEnded  {
            return "closeHand"
        } else {
            return "openHand"
        }
    }
    
    func replaceSalak() -> String {
        return isLongPressed ? "crackedSalak" : "salak"
    }
}

struct Scene9_Previews: PreviewProvider {
    static var previews: some View {
        Scene9()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
