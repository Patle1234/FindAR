//
//  CardView.swift
//  TinderClone
//
//  Created by Franck-Stephane Ndame Mpouli on 19/02/2021.
//

import SwiftUI

struct CardView: View {
    @State var card: Card
    // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.5)])
   
    
    var body: some View {
        VStack{
        ZStack(alignment: .topLeading) {
            Image(card.imageName)
                .resizable()
                .clipped()
                .zIndex(1.0)
            
            Rectangle().background(Color.green)
                .zIndex(0.0)
                
            
            // Linear Gradient
//            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
//            VStack {
//                Spacer()
//                VStack(alignment: .leading){
//                    HStack {
//                        Text(card.name).font(.largeTitle).fontWeight(.bold)
//                        Text(String(card.age)).font(.title)
//                    }
//                    Text(card.company).font(.body)
//                }
//            }
//
//            .padding()
//            .foregroundColor(.white)
//
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:150)
                    .opacity(Double(card.x/10 - 1))
                Spacer()
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:150)
                    .opacity(Double(card.x/10 * -1 - 1))
            }
//TODO: hello beta
        }
        .background(.white)
        .frame(width: 320, height: 320, alignment: .center)
        .cornerRadius(8)
        .offset(y: 34)
        
        
            
           
              
                
                    HStack {
                        Text(card.name).font(.largeTitle).fontWeight(.bold)
                        Text(String(card.age)).font(.title)
                    }.offset(x: -64, y: 26)
                    Text(card.company).font(.body).offset(x: -100, y: 16)
                
            
           
            .padding()
            .foregroundColor(.white)
            .offset(y: -30)
            
        }.frame(width: 350, height: 420, alignment: .center)
            .background(Color.gray)
            .cornerRadius(8)
        
            .rotationEffect(.init(degrees: card.degree))
            .gesture (
                DragGesture()
                    .onChanged { value in
                        withAnimation(.default) {
                            print("TOUCHY")
                            card.x = value.translation.width
                            
                                
                            // MARK: - BUG 5
                            card.y = value.translation.height
                            card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                        }
                    }
                    .onEnded { (value) in
                        withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                            switch value.translation.width {
                            case 0...100:
                                card.x = 0; card.degree = 0; card.y = 0
                            case let x where x > 100:
                                card.x = 500; card.degree = 12
                            case (-100)...(-1):
                                card.x = 0; card.degree = 0; card.y = 0
                            case let x where x < -100:
                                card.x  = -500; card.degree = -12
                            default:
                                card.x = 0; card.y = 0
                            }
                        }
                    }
            )
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.data[0])
            .previewLayout(.sizeThatFits)
    }
}
