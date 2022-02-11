//
//  ContentView.swift
//  Shared
//
//  Created by Dev Patel on 2/4/22.
//

import SwiftUI
import FirebaseAuth

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
    let id = UUID()
    let name: String
    let imageName: String
    let age: Int
    let company: String
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
    
    static var data: [Card] {
        [
            Card(name: "Treadmill", imageName: "treadmill", age: 21, company: "Athletico"),
            Card(name: "Dumbbell", imageName: "dumbbell", age: 23, company: "Pena's Weights Inc."),
            Card(name: "Bike", imageName: "bike", age: 26, company: "Lifetime Fitness")        ]
    }
    
}
struct cardView: View{
    var body: some View {
        ZStack{
            
            ForEach(Card.data.reversed()) { card in
                CardView(card: card)
            }
            
            
        }.frame(width: 350, height: 550, alignment: .center)
        .padding(8)
        .zIndex(1.0)
        .offset(y: -150)
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
                    .frame(width:100, height:30)
                    .background(Color.black)
                    .foregroundColor(Color.blue)
                    .cornerRadius(8)
                    .padding()
                    
                  
            })
            
            Button(action: {
                userVM.deleteUser(user: currentPerson)
                viewModel.signOut()
            }, label: {
                Text("Delete Account")
                    .frame(width:100, height:30)
                    .background(Color.black)
                    .foregroundColor(Color.red)
                    .cornerRadius(8)
                    .padding()
                    
                  
            })
            
        }
        
    }
}




struct mainView: View{
    @EnvironmentObject var viewModel: SignIn
    @ObservedObject var userVM = UserListViewModel()//list object
    let userID=Auth.auth().currentUser?.uid
   
    var body: some View {
<<<<<<< Updated upstream
        
        
=======
<<<<<<< HEAD

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
            
//        Color.green.ignoresSafeArea()
=======
        
>>>>>>> 184a7de36e235feb19c7ffce9eed512f15296b00
        
>>>>>>> Stashed changes
        
        VStack{
           
<<<<<<< HEAD

                
=======
                ZStack{
                  
                    ForEach(Card.data.reversed()) { card in
                        CardView(card: card)
                    }
                }.frame(width: 350, height: 350, alignment: .center)
                .padding(8)
                .zIndex(1.0)
                .offset(y: -50)
//                .background(.gray)
<<<<<<< Updated upstream
=======
>>>>>>> 184a7de36e235feb19c7ffce9eed512f15296b00
>>>>>>> Stashed changes
            
            
            
            
                
            

                
                
                
            
        }.background(Color(red: 0.785, green: 0.785, blue: 0.785))
//            .frame(width: 350, height: 420, alignment: .center)
//
//            .cornerRadius(8)
//
//            .position(x: 193, y: 180)
    }
}
