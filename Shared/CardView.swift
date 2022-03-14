//
//  CardView.swift
//  TinderClone
//
//  Created by ritesh patel on 19/02/2021.
//
import SwiftUI
import FirebaseStorage

struct CardView: View {
    @State var card: Card
    @State var ifLikeProd = false
    @ObservedObject var prodVM = ProductListViewModel()
    @State var ifView = false
    @State private var imageURL = URL(string: "")
    @State private var showSafari: Bool = false

    
    // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.0)])
    
    var body: some View {
        Button(action: {
            ifView.toggle()
            print("want to view")
        }, label: {
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
                                //vraj do stuff here
                                print(card.prod)
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
        })
            .sheet(isPresented: $ifView, content: {
                HStack{
                    VStack{
                        
                        Text("Name: \(card.prod.productName)")
                        Text("Description: \(card.prod.description)")
                        Text("Catagory: \(card.prod.category)")
                        Text("Show the AR")
                             .foregroundColor(.blue)
                             .padding()
                             .onTapGesture {
                                 print("usdzName:\(card.prod.usdzName)")
                                 self.loadImageFromFirebase(name:card.prod.usdzName)
                                showSafari.toggle()
                                 print("imageURL: \(imageURL)")
                             }
                             .fullScreenCover(isPresented: $showSafari, content: {
                                 SFSafariViewWrapper(url: URL(string:"https://firebasestorage.googleapis.com/v0/b/findar-4a4c0.appspot.com/o/models%2FAirForce.usdz?alt=media&token=d16553ac-abe9-41b4-a388-67b7429e68ae")!)

//                                 SFSafariViewWrapper(url: imageURL!)
                                 
            //                         SFSafariViewWrapper(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/findar-4a4c0.appspot.com/o/models%2FAirForce.usdz?alt=media&token=d16553ac-abe9-41b4-a388-67b7429e68ae")!)
                             })
                    }
                }
            })
 
    }
    func loadImageFromFirebase(name:String) {
        print("called: models/\(name).usdz")
        var storageRef = Storage.storage().reference(withPath: "models/\(name).usdz")
        print(storageRef)
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print("error")
                print((error?.localizedDescription)!)
                return
            }else{
                self.imageURL = url!
            }
        }
    }
}



//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: Card.data[0])
//            .previewLayout(.sizeThatFits)
//    }
//}
