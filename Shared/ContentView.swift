//
//  ContentView.swift
//  Shared
//
//  Created by Dev Patel on 2/4/22.
//

import SwiftUI
import FirebaseAuth
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

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
            viewModel.signedIn = viewModel.isSignedIn
            
            
            
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
                        .foregroundColor(index == 0 ? .black: .gray)
                    

                    
                    ZStack{
                        Capsule()
                            .fill(Color.black.opacity(0.04))
                            .frame(height:4)
                        
                        if index==0{
                            Capsule()
                                .fill(Color.black)
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
                        .foregroundColor(index == 1 ? .black: .gray)
                    ZStack{
                        Capsule()
                            .fill(Color.black.opacity(0.04))
                            .frame(height: 4)
                        
                        if index==1{
                            Capsule()
                                .fill(Color.black)
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
                            .foregroundColor(Color.black)
                            .padding()
                        SecureField("Password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(Font.system(size: 25, design: .default))
                            .cornerRadius(8)
                            .foregroundColor(Color.black)
                            .foregroundColor(Color("LightYellow"))
                            .background(Color("DarkPurple"))
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
    @ObservedObject var productData = ProductRepository()
    
    //array of products
    lazy var prodDataArr = productData.products
    
    //arrays of each product's reviews
    lazy var prod1Revs = prodDataArr[0].reviews
    lazy var prod2Revs = prodDataArr[1].reviews
    lazy var prod3Revs = prodDataArr[2].reviews
    
    //sums of each products review
    lazy var prod1RevAvg = prod1Revs?.reduce(0, +)
  
    lazy var prod2RevAvg = prod1Revs?.reduce(0, +)
    lazy var prod3RevAvg = prod1Revs?.reduce(0, +)
    
    
    let id = UUID()
    let name: String
    let imageName: String
//    let age: Int
    let company: String
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
    
    var rating: Double
    
    
    
//    var newCardName
//    var newCardCompany
//    var newCardDescription
//    var newCardCategory
    
    static var data: [Card] {
        [
            
            
                
                
            
            Card(name: "Treadmill", imageName: "treadmill",  company: "Athletico", rating: round(Double.random(in: 1..<3)*10)/10),
            Card(name: "Dumbbell", imageName: "dumbbell",  company: "Pena's Weights Inc.", rating: round(Double.random(in: 1..<3)*10)/10),
            Card(name: "Bike", imageName: "bike", company: "Lifetime Fitness", rating: round(Double.random(in: 1..<3)*10)/10)        ]
    }
    
    
   
    
}
struct cardView: View{
    @State var ifAddProduct = false
    @State var newProductName=""
    @State var newCompany = ""
    @State var newDescription = ""
    @State var newCategory = ""
    let database = Firestore.firestore()
    
    let categoriesTemp: [String] = ["Clothes", "Workout Equipment", "Electronics"]
  
    @ObservedObject var productRepo = ProductRepository()
    
    var body: some View {
        VStack{
        ZStack{
            
            ForEach(Card.data.reversed()) { card in
                CardView(card: card)
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
        .sheet(isPresented: $ifAddProduct, content: {
           
            
            TextField("Product Name",text: $newProductName)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(Font.system(size: 25, design: .default))
                .cornerRadius(8)
//                .background(Color.blue)
                .padding()
            
            TextField("Company",text: $newCompany)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(Font.system(size: 25, design: .default))
                .cornerRadius(8)
//                .background(Color.blue)
                .padding()
            
            TextField("Description",text: $newDescription)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(Font.system(size: 25, design: .default))
                .cornerRadius(8)
//                .background(Color.blue)
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
                       var newId = database.collection("products").document().documentID
                   productRepo.addProduct(Product(productId: newId, productName: newProductName, company: newCompany, description: newDescription, category: newCategory))
                 
                   
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
                .buttonStyle(StyleButton(color: Color.red))
        })
    }
}
               



struct settingsView: View{//show settings
    @EnvironmentObject var viewModel: SignIn
    @ObservedObject var userRepo = UserRepository()
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
                .buttonStyle(StyleButton(color: Color.red))
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
                .buttonStyle(StyleButton(color: Color.red))
                .padding()

            
            
            
            
            
            
            
            
            
            
        }
        
    }
}




struct mainView: View{
    @EnvironmentObject var viewModel: SignIn
    @ObservedObject var userVM = UserListViewModel()//list object
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
                            Image(systemName:"menucard")
                        })

            ForEach(userVM.UserCellViewModels){currentUser in
                if((currentUser.user.userId)==userID){
                    let _=print("helloji")
                    settingsView(currentPerson: currentUser.user)
                        .tabItem({
                            Image(systemName:"gear")
                            Text("Settings")
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
