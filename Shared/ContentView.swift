//
//  ContentView.swift
//  Shared
//
//  Created by Dev Patel on 2/4/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: SignIn
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                //TODO: WHEN SIGNED IN
                mainView()

            }else{
                SignInView()
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
struct SignInView: View {
    @State var email=""
    @State var password=""
    @EnvironmentObject var viewModel: SignIn

    var body: some View {

        VStack{
           
//            let _=print("in the thign here")
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
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
                    .frame(width: 200, height: 50, alignment: .center)
                    .cornerRadius(8)
            }
            .padding()
            Color("LightPurple")



        }
        .background(Color("LightPurple"))
        .navigationTitle("Sign In")
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
        .navigationTitle("Create Account").foregroundColor(Color("LightYellow"))
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
            Card(name: "Bike", imageName: "bike", age: 26, company: "Lifetime Fitness")
//            Card(name: "Zoé", imageName: "p3", age: 20, bio: "Law grad"),
//            Card(name: "Tilly", imageName: "p4", age: 21, bio: "Follow me on IG"),
//            Card(name: "Penny", imageName: "p5", age: 24, bio: "J'aime la vie et le vin 🍷"),
        ]
    }
    
}




//main view shown after signing in

struct mainView: View{//show settings
    @EnvironmentObject var viewModel: SignIn
    
   
    var body: some View {
        
        
        
        VStack{
           
                ZStack{
                  
                    ForEach(Card.data.reversed()) { card in
                        CardView(card: card)
                    }
                }.frame(width: 350, height: 350, alignment: .center)
                .padding(8)
                .zIndex(1.0)
                .offset(y: -50)
//                .background(.gray)
            
            
            
            
                
            
                Button(action: {
                  
                    viewModel.signOut()
                }, label: {
                    Text("Sign Out")
                        .frame(width:100, height:30)
                        .background(Color.black)
                        .foregroundColor(Color.blue)
                        .cornerRadius(8)
                        .padding()
                        
                      
                }).position(x: 326, y: -220)
                
                
                
            
        }.background(Color(red: 0.785, green: 0.785, blue: 0.785))
//            .frame(width: 350, height: 420, alignment: .center)
//
//            .cornerRadius(8)
//
//            .position(x: 193, y: 180)
    }
}
