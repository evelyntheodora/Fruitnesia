//
//  Scene14.swift
//  Salakku
//
//  Created by Evelyn Theodora Siswanto on 11/04/23.
//

import SwiftUI

struct Scene14: View {
    
    @State private var toScene15: Bool = false
    @State private var pageOpacity = 0.0
    
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                ZStack {
                    Image("meat")
                    Image("left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 500)
                        .padding(.trailing, 130)
                        
                    Image("rait")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 500)
                        .padding(.leading, 130)
                }
                .padding(60)
                
                HStack {
                    Text("Now it has")
                    Text("a crack")
                        .fontWeight(.semibold)
                    Text("and it’s easier to peel!")
                }
                .font(.system(size: 48))
                .foregroundColor(Color("textblack"))
                
            }
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0) {
                pageOpacity = 1.0
            }
            .navigationStack()
            .overlay(toScene15 ? Scene15() : nil)
        }
        .onTapGesture {
            toScene15 = true
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
}

struct Scene14_Previews: PreviewProvider {
    static var previews: some View {
        Scene14()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
