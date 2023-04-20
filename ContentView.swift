//
//  ContentView.swift
//  Salakku
//
//  Created by Evelyn Theodora Siswanto on 11/04/23.
//

import SwiftUI

struct ContentView: View {
    var text1: String = "you can only find in Indonesia"
    
    @State private var currentIndex: Int = 0
    @State private var isAnimating: Bool = false
    @State private var toScene3: Bool = false
    @State private var isDimmed: Bool = false
    @State var pageOpacity = 0.0
    
    var body: some View {
        
        ZStack (alignment: .top) {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("peta")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 150)
                    .padding(.bottom, 50)
                VStack {
                    if currentIndex == 0 {
                        Text("There are many fruits that")
                            .font(.system(size: 48))
                            .foregroundColor(Color("textblack"))
                        
                        HStack(spacing: 0){
                            Text("you ")
                            Text("can only find in ")
                                .fontWeight(.semibold)
                            Text("Indonesia")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                        .font(.system(size: 48))
                    } else {
                        Text("and one of them is ...")
                            .font(.system(size: 48))
                            .foregroundColor(Color("textblack"))
                            .padding(.top, 40)
                    }
                }
                .frame(height: 200)
            }
            .animation(.easeInOut, value: isAnimating)
            .padding()
            .padding(.top, 200)
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toScene3 ? Scene3() : nil)
        }
        .onTapGesture {
            self.currentIndex += 1
            toScene3 = currentIndex >= 2 ? true : false
            isAnimating = true
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
