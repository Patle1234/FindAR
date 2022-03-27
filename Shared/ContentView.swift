//
//  ContentView.swift
//  Shared
//
//  Created by Dev Patel on 2/4/22.
//

import SwiftUI
import FirebaseAuth
import CoreTelephony

struct ContentView: View {
    @EnvironmentObject var viewModel: SignIn
    var body: some View {
        NavigationView{
           
            if viewModel.signedIn {
                //TODO: WHEN SIGNED IN
                mainView()

            }else{
                enterView()
            }
        }
        .onAppear{
            //REMOVE THE ! LATER ON
            viewModel.signedIn = !viewModel.isSignedIn

            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//initial sign in view
struct enterView: View {
    @State var index=0
    @Namespace var name

    var body: some View {
        VStack{
        HStack{
            Button(action: {
                withAnimation(.spring()){
                    index = 0
                }
            }, label: {
                //Sign IN
                VStack{
                    Text("Login")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(index == 0 ?  Color("Red"): Color("Orange"))
                    

                    
                    ZStack{
                        Capsule()
                            .fill(Color("Orange"))
                            .frame(height:4)
                        
                        if index==0{
                            Capsule()
                                .fill(Color("Red"))
                                .frame(height:4)
                                .matchedGeometryEffect(id: "Tab", in: name)
                        }
                        
                        
                    }
                    
                }
            })
            
            Button(action: {
                withAnimation(.spring()){
                    index = 1
                }
            }, label: {
                VStack{
                    
                    
                    Text("Sign Up")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(index == 1 ? Color("Red"): Color("Orange"))
                    ZStack{
                        Capsule()
                            .fill(Color("Orange"))
                            .frame(height: 4)
                        
                        if index==1{
                            Capsule()
                                .fill(Color("Red"))
                                .frame(height:4)
                                .matchedGeometryEffect(id: "Tab", in: name)
                        }
                        

                    }
                    //.fill(Color.black)
                    
                }
            })
            
            
            
        }
       // .padding(.top,30)
         
        //Spacer()
            
            if index==0{
                SignInView()
            }else if index==1{
                SignUpView()
            }
            
        }
        .background(Rectangle()
                        .foregroundColor(Color("Blue"))
                        .frame(width: 1000, height: 1000))
    }
}




struct SignInView: View {
    @State var email=""
    @State var password=""
    @EnvironmentObject var viewModel: SignIn
    
    var body: some View {
                VStack{
                    VStack{
                        TextField("Email Address",text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(Font.system(size: 25, design: .default))
                            .cornerRadius(8)
                            .foregroundColor(Color("DarkBlue"))
                            .background(Color("Blue"))
                            .padding()
                        SecureField("Password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(Font.system(size: 25, design: .default))
                            .cornerRadius(8)
                            .foregroundColor(Color("DarkBlue"))
                            .background(Color("Blue"))
                            .padding()
        
                        Button(action: {
                            guard !email.isEmpty, !password.isEmpty else {//if the textfields are empty
                                return
                            }
                            viewModel.signIn(email: email, password: password)
                        }, label: {
                            Text("Sign In")
                                .frame(width: 200, height: 50, alignment: .center)
                                .cornerRadius(8)
        
                        })
                            .buttonStyle(StyleButton(color: Color("DarkBlue"), forgroundColor: Color("Orange")))

//                        NavigationLink("Create Account", destination: SignUpView())
//                            .padding()
//                            .frame(width: 200, height: 50, alignment: .center)
//                            .cornerRadius(8)
                    }
                    .padding()
                }
    }
}




//sign up create account view
struct SignUpView: View {
    @State var email=""
    @State var password=""
    @State var firstName=""
    @State var lastName=""
    @State var uName=""

    @EnvironmentObject var viewModel: SignIn

    var body: some View {
        VStack{
            VStack{
                TextField("Email Address",text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .padding()

                TextField("User Name",text: $uName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .padding()
                Button(action: {
                    print("?")
                    guard !email.isEmpty, !password.isEmpty else {//if the textfields are empty
                        return
                    }
                    //create User
                    viewModel.signUp(email: email, password: password,userName: uName)
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(Color.blue)
                        .cornerRadius(8)

                })
                    .buttonStyle(StyleButton(color: Color("DarkBlue"), forgroundColor: Color("Orange")))
                    .padding()

            }
            .padding()
            //Color("LightPurple")
        }
        //.navigationTitle("Create Account").foregroundColor(Color("LightYellow"))
    }
}







//struct SignInView: View {
//    var body: some View {
//
//        Button("Joe", action: {
//                           print("?")
//
//
//                       }
//    )}
//}












struct Card: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
   
//    let age: Int
    let company: String
    let prod: Product
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
    @ObservedObject var prodVM = ProductListViewModel()
    var prodsArr = ProductListViewModel().ProductCellViewModels
//    let _ = print(ProductListViewModel().ProductCellViewModels.count)
    let _2 = print("betaaa")
 
    
//    static var data: [Card] {
//        [
//            Card(name: "Treadmill", imageName: "treadmill",  company: "Athletico"),
//            Card(name: "Dumbbell", imageName: "dumbbell",  company: "Pena's Weights Inc."),
//            Card(name: "Bike", imageName: "bike", company: "Lifetime Fitness")]
//
//    }
            

        
            
    
    
    
}


struct cardView: View{
    @State var ifAddProduct = false
    @State var newProductName=""
    @State var newCompany = ""
    @State var newDescription = ""
    @State var newCategory = "Clothes"
    @State var stuff = []
    
    
    let categoriesTemp: [String] = ["Clothes", "Workout Equipment", "Electronics"]
  
    @ObservedObject var prodVM = ProductListViewModel()
    
    var body: some View {
        VStack{
        ZStack{
            
            
                
                
            ForEach(prodVM.ProductCellViewModels.reversed()) {product in
                
                let ___ = print("okok")
//                let _ = stuff.append(product)
//                let __ = print(stuff)
                CardView(card: Card(name: product.product.productName, imageName: "dumbbell",  company: product.product.company, prod: product.product))
            }
            
            
        }.frame(width: 350, height: 550, alignment: .center)
        .padding(15)
        .zIndex(1.0)
        .offset(y: -50)
        
        
        
        
            HStack{
                Spacer()
                Button(action: {//add a task button
                    
                    
                    
//                    productRepo.addProduct(Product(productName: "dumbbells", company: "Lifetime Fitness", description: "20 lbs", category: "Workout items"))
                    
                    
                    
                    
                    
                    //TODO: uncomment later
                    ifAddProduct.toggle()
                }, label: {
                    Text("+")
                        .font(.system(.largeTitle))
                        .frame(width: 77, height: 70)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 7)
                })
                    .background(Color.blue)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    .offset(x: -10, y: -50)
                    
            }
        }
        .background(Rectangle()
                        .foregroundColor(Color("Blue"))
                        .frame(width: 1000, height: 1000))
        .sheet(isPresented: $ifAddProduct, content: {
            VStack{
            
            TextField("Product Name",text: $newProductName)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(Font.system(size: 25, design: .default))
                .cornerRadius(8)
                .foregroundColor(Color("DarkBlue"))
                .background(Color("Blue"))
                .padding()
            
            TextField("Company",text: $newCompany)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(Font.system(size: 25, design: .default))
                .cornerRadius(8)
                .foregroundColor(Color("DarkBlue"))
                .background(Color("Blue"))
                .padding()
            
            TextField("Description",text: $newDescription)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(Font.system(size: 25, design: .default))
                .cornerRadius(8)
                .foregroundColor(Color("DarkBlue"))
                .background(Color("Blue"))
                .padding()
            
//            Picker("Select a paint color", selection: $category) {
//                            ForEach(categoriesTemp, id: \.self) {
//                                Text($0)
//                            }
//                        }
//            .pickerStyle(.wheel)
//            .padding()
            
            
          //TODO: make this look nicer;  wheel picker?
            Picker(
                selection: $newCategory, label:
                   
                HStack {
                    Text("Category:")
                    Text(newCategory)
                }
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .padding(.horizontal)
//                    .background(Color.blue)
//                    .cornerRadius(10)
                    
                   ,
                   content: {
                ForEach(categoriesTemp, id: \.self) { option in
                    HStack{
                        Text(option)
                    }
                    .tag(option)
                    
                       
                }
            }).pickerStyle(MenuPickerStyle())
                .padding()
                
            

               Button(action: {
                   ifAddProduct.toggle()
                   //TODO: ADD THE PRODUCT TO FIREBASE
            
                   guard !newProductName.isEmpty, !newCompany.isEmpty, !newDescription.isEmpty, !newCategory.isEmpty else {//if the textfields are empty
                       return
                   }
                   print("test")
                   
                   //vraj here is new product newProd variable
                   var newProd = Product(productName: newProductName, company: newCompany, description: newDescription, category: newCategory)
                   prodVM.addProduct(product: newProd)
                 
                   
//                    productRepo.addProduct(Product(productName: "dumbbells", company: "Lifetime Fitness", description: "20 lbs", category: "Workout items"))
                   
                   
                   newProductName=""
                   newCompany = ""
                  newDescription = ""
                   newCategory = ""
                   
               }, label: {
                   Text("Create Item")
                       .cornerRadius(8)
                       .padding()
                       .frame(width:100, height:30)
               })
                .buttonStyle(StyleButton(color: Color("DarkBlue"), forgroundColor: Color("Orange")))
            }
                    .background(Rectangle()
                                    .foregroundColor(Color("Blue"))
                                    .frame(width: 1000, height: 1000))
            
        })
        //dont delete
        .onAppear(perform: addProdcuts)
//        .background(Rectangle()
//                        .foregroundColor(Color("Blue"))
//                        .frame(width: 1000, height: 1000))
//    }
    }
        //dont delete
    func addProdcuts(){
        
        //columns.removeAll()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//        print("Array")
//            if (prodVM.returnProduct().productName != ""){
//        productList.append(prodVM.returnProduct())
//            }
//        print(productList)
//        addProdcuts()
    }
    }
    
    

let events = ["Birthday", "Funeral", "Race", "Mom"]
let data = ["Treadmill", "Bike", "Car", "Computer","Ipad", "Tablet", "Screen"]
 


struct productListItems: Identifiable {
    var id = UUID()
    var name: String
    var desc: String
    var image: String
//    var image: String
}
var products = [
    productListItems(name: "Treadmill", desc: "Desc here", image: "treadmill"),
    productListItems(name: "Bike", desc: "Desc here", image:"bike"),
    productListItems(name: "Book", desc: "You use this to train your eyes and knowledge", image: "book")
 
]
public var productsList = [Product(id: "", productId: "", productName: "", company: "", description: "", category: "")]

public var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)


struct saveView: View{
    @State private var isExpanded = false
     @State private var selNum = "";
    let spacing: CGFloat = 10
    @State private var numberOfRows = 2
    @State private var show = false;
    @State private var int = 0;


    var body: some View {
       
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(0..<CardView.productList.count) { num in
                    if(CardView.productList[num].productName != ""){
                        Button(action: {
                            show = true;
                            int = num;
                            Swift.print("doggy")
                            
                        }) {
                            ItemView(product: CardView.productList[num])

                        }
                    }
                    
                }
                
                
            }.padding(.horizontal)

        
            
        } .background(Rectangle()
            .foregroundColor(Color("Blue"))
            .frame(width: 1000, height: 1000))
            .sheet(isPresented: $show, content: {
                          //let _=loadImageFromFirebase(name: card.prod.imageName)
                          
                                  VStack{
                                      Text("**\(CardView.productList[int].productName)**")
                                      

                                      

//                                      WebImage(url: imageURL!)
//                                          .resizable()
//                                          .clipped()
//                                          .scaleEffect(x: 0.8, y: 0.5, anchor: .center)
//

                                      Text("Description: \(CardView.productList[int].description)")
                                      Text("Catagory: \(CardView.productList[int].category)")
                                  
                              
                          }
            }
                   )
        
        
            .onAppear(perform: print)
            }
    func print(){
        Swift.print("Array")
        Swift.print(CardView.productList)
    }
    
  
    }
struct ItemView: View{
    
    let product: Product
    var body: some View{
        GeometryReader {
            reader in
            VStack(spacing: 5){
                Image("treadmill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.blue)
                    .frame(width:50)
                Text(product.productName)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
                            
            }.frame(width: reader.size.width, height: reader.size.height)
                .background(Color.white)
        }.frame(height:150)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.2), radius: 10,y: 5)
            //.onAppear(perform: delete)
    }
//    func delete(){
//        columns.removeAll()
//    }
}
class ProductListModel: ObservableObject {
    @Published var prodList: [Product] = [Product(id: "", productId: "", productName: "f", company: "", description: "", category: "")]
}
struct Events: Identifiable{
    var id =  UUID()
    var name: String
    var products: Array<Int>
    var show: Bool?
}
struct eventView: View{
    @StateObject var viewModel = ProductListModel()
    @State private var isExpanded = false
    @State private var selNum = "";
    @State private var showEventAdd = false;
    @State private var eventInp: String = ""
    @State  private var prod: String = ""
    @State var eventList = [Events(id: UUID(), name: "Birthday", products: [0,1])]
    @State var prodPicked = false;
    @State var indexes = [-1]
    @State var breakHap = false
    @State var prodNames = []

    var body: some View{
        
        VStack{
           
        List{
            ForEach (eventList) { num in
                DisclosureGroup("\(num.name)", isExpanded: $isExpanded) {
                                        ScrollView{
                                            VStack{
                                                ForEach(num.products, id: \.self) {
                                                            myData in
                                                    HStack{
                                                        VStack(alignment: .leading){
                                                            Text("\(CardView.productList[myData].productName)")
                                                                .font(.system(size: 18, weight: .bold))
                                                            Text("\(CardView.productList[myData].description)")
                                                            
                                                    }
                                                        Spacer()
                                                        
                                                        Image("treadmill")
                                                            .resizable()
                                                            .frame(width: 100, height: 100)
                                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                                    }
                                                        .onTapGesture {
                                                            self.selNum = "myData"
                                                        withAnimation{
                                                            self.isExpanded
                                                            .toggle()
                                                        }
                                                        }
                                                }
                                            }
                                        }.frame(height:150)
                                }.accentColor(.white)
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.all)
                                .background(Color.blue)
                                .cornerRadius(8)
                            }
        
                        }
            
           
            Button(action: {
                showEventAdd = true;
                viewModel.prodList.append(Product(id: "", productId: "", productName: "h", company: "", description: "", category: ""))
            }, label: {
                Text("+")
                    .font(.system(.largeTitle))
                    .frame(width: 77, height: 70)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 7)
            })
                .background(Color.blue)
                .cornerRadius(38.5)
                .padding()
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                .offset(x: -10, y: -50)
            
        }                               .background(Rectangle()
                                        .foregroundColor(Color("Blue"))
                                        .frame(width: 1000, height: 1000))
            .sheet(isPresented: $showEventAdd, content: {
        
                VStack(){
                    Spacer()
                TextField("Add Event Here", text: $eventInp)
                    
                    
                    Text(prodNames.description)
                    Button(action: {
                        prodNames.removeAll()
                        indexes.removeAll()
                    }, label: {
                        Text("Clear")
                    })
                    
                    
                    
                    Button(action: {
                        showEventAdd = true;
                        viewModel.prodList.append(Product(id: "", productId: "", productName: "h", company: "", description: "", category: ""))
                    }, label: {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 77, height: 70)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
                    NavigationView{
                    List{
                        ForEach(0..<CardView.productList.count) { num in
                            HStack{
                                VStack(alignment: .leading){
                                    Text("\(CardView.productList[num].productName)")
                                        .font(.system(size: 18, weight: .bold))
                                    Text("\(CardView.productList[num].description)")
                                    
                            }
                                Spacer()
                                
                                Image("treadmill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                               
                                Button(action: {
                                   print(num)
                                    //save this
//                                    if( indexes.count > 0){
//                                    for ind in 0...indexes.count-1 {
//                                        if (indexes[ind] as! Int == num){
//                                            indexes.remove(at: ind)
//                                            breakHap = true;
//                                            break
//                                        }
//                                        breakHap = false
//                                    }
//                                    }
//                                    if (!breakHap){
//                                        indexes.append(num)
//                                    }
//                                    if(breakHap && indexes.isEmpty){
//                                        indexes.append(num)
//                                    }
                                    if(!indexes.isEmpty){
                                    for ind in 0...indexes.count-1 {
                                        if (indexes[ind] as! Int == num){
                                            breakHap = true
                                            break
                                        } else {
                                            breakHap = false
                                        }
                                    }
                                    }
                                    if(!breakHap || indexes.isEmpty){
                                        indexes.append(num)
                                        prodNames.append(CardView.productList[num].productName)
                                    }
                                    print(indexes)
                                
                                }) {
                                    Text("Pick")
                                }
                                
                            }
                           
                            
                    }
                    }.navigationBarTitle("Products")
                                                
                        
                    
                }
                    Button(action: {
                        for i in 0...indexes.count-1{
                            print(indexes.count)
                            if (indexes[i] == -1){
                                indexes.remove(at: i)
                                break

                            }
                        }
                        
                        eventList.append(Events(id: UUID(), name: eventInp, products: indexes))
                        showEventAdd = false;
                    }) {
                        Text("Create Event")
                    }
                       
                        
                }
                //.onAppear(perform: delete)
            })
      
    }
//    func delete(){
//        for num in CardView.productList{
//            if(num.productName = ""){
//                CardView.productList.remove
//            }
//
//
//        }
//    }
}

 
    



struct settingsView: View{//show settings
    @EnvironmentObject var viewModel: SignIn
    @ObservedObject var userwhRepo = UserRepository()
    @ObservedObject var userVM = UserListViewModel()
    @State var currentPerson:User
    
    var body: some View {
        VStack{
            Button(action: {
                viewModel.signOut()

            }, label: {
                Text("Sign Out")
                    .cornerRadius(8)
                    .padding()
                    .frame(width:120, height:30)

            })
                .buttonStyle(StyleButton(color: Color("DarkBlue"), forgroundColor: Color("Orange")))
                .padding()


            Button(action: {
                userVM.deleteUser(user: currentPerson)
                viewModel.signOut()
            }, label: {
                Text("Delete Account")
                    .cornerRadius(8)
                    
                    .padding()
                    .frame(width:120, height:30)
            })
                .buttonStyle(StyleButton(color: Color("DarkBlue"), forgroundColor: Color("Orange")))
                .padding()
        }
        .background(Rectangle()
                        .foregroundColor(Color("Blue"))
                        .frame(width: 1000, height: 1000))
        
    }
}




struct mainView: View{
    @EnvironmentObject var viewModel: SignIn
    @ObservedObject var userVM = UserListViewModel()//list object
    @ObservedObject var prodVM = ProductListViewModel()
    @State private var show = true
    let userID=Auth.auth().currentUser?.uid
   
    var body: some View {

//        Button(action: {
//            viewModel.signOut()
//
//        }, label: {
//            Text("Sign Out")
//                .frame(width:100, height:30)
//                .background(Color.black)
//                .foregroundColor(Color.blue)
//                .cornerRadius(8)
//                .padding()
//
//
//        })
        TabView{
                    cardView()
                        .tabItem({
                            Text("Cards")
                                .background (Color("Orange"))
                            Image(systemName:"menucard")
                                .background(Color("Orange"))
                    })
        saveView()
                       
                               .tabItem({
                                   Text("Saved Items")
                                       .background(Color("Red"))
                                   Image(systemName: "trash")
                                       .background(Color("Red"))
                                       
                               })
        eventView()
            
                    .tabItem({
                        Text("Events")
                            .background(Color("Red"))
                        Image(systemName: "trash")
                            .background(Color("Red"))
                            

                    })

            ForEach(userVM.UserCellViewModels){currentUser in
//                let _1 = print("joejeo")
//                let _3=print(userVM.UserCellViewModels.count)
                
              
                
                if((currentUser.user.userId)==userID){
//                    let _2=print("helloji")
                    settingsView(currentPerson: currentUser.user)
                        .tabItem({
                            Image(systemName:"gear")
                                .background(Color("Orange"))
                            Text("Settings")
                                .background(Color("Orange"))
                        })
                }
            }
        
        
            
        }

        
        VStack{
           

                
//                ZStack{
//
//                    ForEach(Card.data.reversed()) { card in
//                        CardView(card: card)
//                    }
//                }.frame(width: 350, height: 350, alignment: .center)
//                .padding(8)
//                .zIndex(1.0)
//                .offset(y: -50)
            
        }.background(Color(red: 0.785, green: 0.785, blue: 0.785))
    }
 
    
   
}


