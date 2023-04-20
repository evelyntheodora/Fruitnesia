//
//  CardView.swift
//  salakku
//
//  Created by Evelyn Theodora Siswanto on 13/04/23.
//

import SwiftUI

struct CardView: View {
    //    @State var isFlipped: Bool = false
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    @State private var toHome = false
    @State private var pageOpacity = 0.0
    
    let width : CGFloat = 800
    let height : CGFloat = 700
    let durationAndDelay : CGFloat = 0.3
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.easeIn(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.easeOut(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.easeIn(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.easeOut(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 20) {
                ZStack {
                    CardBack(width: width, height: height, degree: $backDegree)
                    CardFront(width: width, height: height, degree: $frontDegree)
                }
                .scaleEffect(0.9)
                Text("Tap anywhere to flip cards")
                    .font(.system(size: 36))
                    .opacity(0.5)
            }
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0.2) {
                pageOpacity = 1.0
            }
            
            
            VStack {
                Image("retry")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .padding(.trailing, 90)
                
                Text("Play again")
                    .font(.system(size: 30))
                    .padding(.trailing, 100)
                    .padding(.bottom, 20)
            }
            .opacity(pageOpacity)
            .opacityEaseIn(delayCount: 0.2) {
                pageOpacity = 1.0
            }
            .onTapGesture {
                toHome = true
            }
            .opacity(0.5)
            .position (x: UIScreen.main.bounds.size.width*14/15, y: UIScreen.main.bounds.size.height*9/10)
            .navigationStack()
            .overlay(toHome ? Scene0() : nil)
        }
        .onTapGesture {
            flipCard ()
        }
    }
}

struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: width, height: height)
                    .cornerRadius(20)
                    .shadow(radius: 10, x: 0, y:5)
                    .foregroundColor(.white)
                
                VStack (alignment: .leading, spacing: 28) {
                    
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Geography")
                            .fontWeight(.bold)
                            .font(.system(size: 48))
                        HStack{
                            Text("Snakefruit is native to Indonesia, however, over time it has naturalized in neighboring countries such as Malaysia and Timor.")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Taste")
                            .fontWeight(.bold)
                            .font(.system(size: 48))
                        HStack{
                            Text("Sweet")
                                .foregroundColor(Color("green"))
                            Text("and tangy with")
                            Text("crunchy")
                                .foregroundColor(Color("accent"))
                            Text("texture")
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Fun Fact")
                            .fontWeight(.bold)
                            .font(.system(size: 48))
                        Text("Consuming too much Snakefruit will get you")
                        HStack {
                            Text("constipation")
                                .fontWeight(.semibold)
                            Text("🤯 as it is too high in fiber")
                        }
                    }
                    
                    HStack (alignment: .bottom) {
                        Image(systemName: "square.and.arrow.down")
                            .font(.system(size: 50))
                            .opacity(0.5)
                            .onTapGesture {
                                let imageSaver = ImageSaver()
                                
                                imageSaver.writeToPhotoAlbum(image: UIImage(named: "cardFront")!)
                                imageSaver.writeToPhotoAlbum(image: UIImage(named: "cardBack")!)
                            }
                        
                        Spacer()
                        
                        VStack (alignment: .trailing) {
                            Image("peta")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                        }
                    }
                }
                .padding(40)
            }
            .padding()
            .frame(width: width, height: height)
            .font(.system(size: 36))
            .foregroundColor(Color("textblack"))
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}


struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .frame(width: width, height: height)
                    .cornerRadius(20)
                    .shadow(radius: 10, x: 0, y:5)
                    .foregroundColor(.white)
                
                VStack (spacing: 10) {
                    ZStack{
                        Image("salak")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 240)
                            .offset(x: -50)
                        
                        Image("meat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .offset(x: 70, y: 45)
                    }
                    
                    HStack {
                        Text("Salak")
                            .fontWeight(.bold)
                        Text("or")
                            .foregroundColor(Color("textblack"))
                        Text("Snakefruit")
                            .fontWeight(.bold)
                            .foregroundColor(Color("textblack"))
                    }
                    .foregroundColor(Color("accent"))
                    .font(.system(size: 60))
                    .padding(.top, 50)
                    
                    VStack {
                        Text("A species of palm native to Java &")
                        Text("Sumatra that bears a unique fruit")
                    }
                    .foregroundColor(Color("textblack"))
                    .font(.system(size: 36))
                }
            }
            
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
        
    }
    
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

