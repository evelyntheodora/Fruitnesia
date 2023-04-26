//
//  Scene15.swift
//  salakku
//
//  Created by Evelyn Theodora Siswanto on 12/04/23.
//

import SwiftUI

struct Scene15: View {
    @State private var isEnded: Bool = false
    @State private var locationLeft: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width * 2 / 5, y: UIScreen.main.bounds.size.height * 2 / 5)
    @State private var locationRight: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width * 1 / 2, y: UIScreen.main.bounds.size.height * 2 / 5)
    @State private var leftIsPlacedCorrectly: Bool = false
    @State private var rightIsPlacedCorrectly: Bool = false
    @State private var pageOpacity = 0.0
    
    @State private var toScene18: Bool = false
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged ({ value in
                isEnded = false
                print(value.location)
                self.locationLeft = value.location
                if value.location.x < 250 {
                    self.leftIsPlacedCorrectly = true
                }
            }
            )
            .onEnded({ value in
                if leftIsPlacedCorrectly {
                    self.locationLeft = CGPoint(x: UIScreen.main.bounds.size.width * 1 / 5, y: UIScreen.main.bounds.size.height * 2 / 5)
                } else {
                    self.locationLeft = CGPoint(x: UIScreen.main.bounds.size.width * 2 / 5, y: UIScreen.main.bounds.size.height * 2 / 5)
                }
                isEnded = true
            })
    }
    var dragRight: some Gesture {
        DragGesture()
            .onChanged ({ value in
                isEnded = false
                print(value.location)
                self.locationRight = value.location
                if value.location.x > 900 {
                    self.rightIsPlacedCorrectly = true
                }
            }
            )
            .onEnded({ value in
                if rightIsPlacedCorrectly {
                    self.locationRight = CGPoint(x: UIScreen.main.bounds.size.width * 5 / 7, y: UIScreen.main.bounds.size.height * 2 / 5)
                } else {
                    self.locationRight = CGPoint(x: UIScreen.main.bounds.size.width * 1 / 2, y: UIScreen.main.bounds.size.height * 2 / 5)
                }
                isEnded = true
            })
    }
    
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack (alignment: .bottom) {
                    if UIScreen.main.bounds.height < 850 {
                        Image("meat")
                            .padding(.top, 140)
                    } else {
                        Image("meat")
                    }
                    
                    HStack {
                        Image("rait")
                            .resizable()
//                            .background(.red)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.size.width
                                   * 1 / 5.5, height: UIScreen.main.bounds.size.height
                                   * 1 / 10)
                            .padding(.leading, 10)
                            .position(locationRight)
                            .gesture(dragRight)
                    }
                    
                    HStack {
                        Image("left")
                            .resizable()
//                            .background(.green)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.size.width
                                   * 1 / 5, height: UIScreen.main.bounds.size.height
                                   * 1 / 20)
                            .padding(.trailing, 10)
                            .position(locationLeft)
                            .gesture(simpleDrag)
                    }
                }
                .padding(.horizontal, 60)
                
                VStack {
                    HStack {
                        Text("Let's peel the skin by")
                        
                        Text("dragging")
                            .fontWeight(.semibold)
                        
                        Text("the skin")
                    }
                    .font(.system(size: 48))
                    .foregroundColor(Color("textblack"))
                    
                    HStack {
                        Text("to the")
                        
                        Text("left")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("green"))
                        
                        Text("and")
                        
                        Text("right")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("red"))
                    }
                    .font(.system(size: 48))
                    .foregroundColor(Color("textblack"))
                }
                .frame(height: 100)
                .padding(.vertical, 150)
//                .padding(150)
            }
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toScene18 ? Scene18() : nil)
        }
        .onTapGesture {
            toScene18 = leftIsPlacedCorrectly && rightIsPlacedCorrectly ? true : false
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
}


struct Scene15_Previews: PreviewProvider {
    static var previews: some View {
        Scene15()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
