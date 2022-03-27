//
//  CardView.swift
//  TinderClone
//
//  Created by ritesh patel on 19/02/2021.
//
import SwiftUI

struct CardView: View {
    @State var card: Card
    @State var ifLikeProd = false
    @ObservedObject var prodVM = ProductListViewModel()
    static var ProductRecent:Product = Product(id: nil, productId: nil, productName: "", company: "", description: "", category: "")
    @State var productsList = []
    static var productList = [Product(id: nil, productId: nil, productName: "", company: "", description: "", category: "")]

    // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.0)])
    func sendProducts() -> Array<Any>{
        return productsList
    }
    var body: some View {
 
        ZStack(alignment: .topLeading) {
            Image(card.imageName)
                .resizable()
                .clipped()
                
                .scaleEffect(x: 0.8, y: 0.5, anchor: .center)
            
            // Linear Gradient
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            VStack {
                Spacer()
                VStack(alignment: .leading){
                    HStack {
                        Text(card.name).font(.largeTitle).fontWeight(.bold).foregroundColor(.red)
//                        Text(String(card.age)).font(.title)
                    }
                    
                }
            }
            .padding()
            .foregroundColor(.gray)
            
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
            
        }
        .background(Color("DarkBlue"))
        .cornerRadius(8)
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
       
        .gesture (
            DragGesture()
                .onChanged { value in
                    withAnimation(.default) {
                        card.x = value.translation.width
                        // MARK: - BUG 5
                        card.y = value.translation.height
//                        card.degree = 1.5 * (value.translation.width > 0 ? 1 : -1)
                        card.degree = 0.02 * (value.translation.width)
                    }
                }
                .onEnded { (value) in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 10, initialVelocity: 0)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100:
                            
                            card.x = 500; card.degree = 12
                           // print(card.prod)
                            //productsList.append(card.prod)
                            //prodVM.addProdToList(product: card.prod)
                            //newProdVM.addProduct(product: card.prod)
                            CardView.ProductRecent = card.prod
                            CardView.productList.append(card.prod)
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



//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: Card.data[0])
//            .previewLayout(.sizeThatFits)
//    }
//}
