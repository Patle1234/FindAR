//
//  CardView.swift
//  TinderClone
//
//  Created by ritesh patel on 19/02/2021.
//
import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct CardView: View {
    @State var card: Card
    @State private var showSafari: Bool = false
    @State var ifLikeProd = false
    @State var ifLoading = true
    @State var ifLoadingImage = true
    @ObservedObject var prodVM = ProductListViewModel()
    static var ProductRecent:Product = Product(id: nil, productId: nil, productName: "", company: "", description: "", category: "",usdzName:"", imageName:"")
    @State var productsList = []
    static var productList = [Product(id: nil, productId: nil, productName: "", company: "", description: "", category: "",usdzName: "", imageName: "")]
    @State private var imageURL = URL(string: "//")
    @State private var modelURL = URL(string: "//")
    @State var ifView = false
    
    
    // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.0)])
    func sendProducts() -> Array<Any>{
        return productsList
    }
    
    var body: some View {
        ZStack{
            Color("DarkBlue")
            Button(action: {
                ifView.toggle()
            }, label: {
                ZStack(alignment: .topLeading) {
                    //                Image(card.imageName)
                    ZStack{
                        if(ifLoadingImage){
                            LoadingView()
                        }else{
                            WebImage(url: imageURL)
                                .resizable()
                                .clipped()
                                .scaleEffect(x: 0.8, y: 0.5, anchor: .center)
                            
                        }
                    }
                    .onAppear{
                        startImageNetworkCall()
                        loadImageFromFirebase(name: card.prod.imageName)

                    }
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
                //            .scaleEffect(x: 0.3, y: 0.5, anchor: .center)
                
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
            })
            .sheet(isPresented: $ifView, content: {
                let _=loadImageFromFirebase(name: card.prod.imageName)
                HStack{
                    ZStack{
                        VStack{
                            Text("**\(card.prod.productName)**")
                            
                            Spacer()
                            
                            //                        Text("\(imageURL?.absoluteString ?? "placeholder")")
                            WebImage(url: imageURL!)
                                .resizable()
                                .clipped()
                                .scaleEffect(x: 0.8, y: 0.5, anchor: .center)
                            
                            Text("Description: \(card.prod.description)")
                            Spacer()
                            Text("Catagory: \(card.prod.category)")
                            Spacer()
                            Text("Show the AR")
                                .foregroundColor(.blue)
                                .padding()
                                .onTapGesture {
                                    showSafari.toggle()
                                }
                                .fullScreenCover(isPresented: $showSafari, content: {
                                    let _=self.loadModelFromFirebase(name:card.prod.usdzName)
                                    ZStack{
                                        
                                        if(ifLoading){
                                            LoadingView()
                                        }else{
                                            SFSafariViewWrapper(url:self.modelURL!)
                                        }
                                        
                                    }
                                    .onAppear{
                                        startNetworkCall()
                                    }
                                })
                        }
                    }
                }
            })
        }
    }
    
    func startNetworkCall(){
        ifLoading=true
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            if(modelURL?.absoluteString ?? "" == "//"){
                let _=print("Firebase Storage Hasn't Updated Model Yet!")
                startNetworkCall()
            }else{
                ifLoading=false
            }
        }
    }
    
    func startImageNetworkCall(){
        ifLoadingImage=true
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            if(imageURL?.absoluteString ?? "" == "//"){
                let _=print("Firebase Storage Hasn't Updated Image Yet!")
                loadImageFromFirebase(name: card.prod.imageName)
                startImageNetworkCall()
            }else{
                ifLoadingImage=false
            }
        }
    }
    
    func loadModelFromFirebase(name:String) {
        print("called: models/\(name).usdz")
        let storageRef = Storage.storage().reference(withPath: "models/\(name).usdz")
        print(storageRef)
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print("error")
                print((error?.localizedDescription)!)
                return
            }else{
                self.modelURL = url!
                print("modelURL: \(self.modelURL!)")
                SFSafariViewWrapper(url:self.modelURL!)
            }
        }
    }
    
    
    func loadImageFromFirebase(name:String) {
        let storageRef = Storage.storage().reference(withPath: "thumbnails/\(name).jpeg")//TODO: ONLY JPEG FILES WORK FOR NOW
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

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color("Blue")
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("DarkBlue")))
        }
    }
}

