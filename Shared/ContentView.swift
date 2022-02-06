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
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SignInView: View {
    @State var email=""
    @State var password=""
    @EnvironmentObject var viewModel: SignIn
    
    var body: some View {
        VStack{
            let _=print("in the thign here")
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











struct mainView: View{//show settings
    @EnvironmentObject var viewModel: SignIn

    var body: some View {
        VStack{
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign Out")
                    .frame(width:250, height:75)
                    .background(Color.black)
                    .foregroundColor(Color.blue)
                    .cornerRadius(8)
                    .padding()
            })
        }
    }
}

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
