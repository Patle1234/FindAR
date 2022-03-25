//
//  SignIn.swift
//  FindAR
//
//  Created by Dev Patel on 2/4/22.
//

import Foundation
import FirebaseAuth
import SwiftUI
import GoogleSignIn
import Firebase

class SignIn: ObservableObject {
    let auth=Auth.auth()
    @Published var signedIn=false
    
    
    var isSignedIn: Bool{
        return auth.currentUser != nil//if the user does or doesn't have a account
    }
    
    
    func signIn(email: String, password:String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            //Sign up success
            DispatchQueue.main.async {
                self?.signedIn=true
            }
        }
    }
    
    
    func signUp(email: String, password:String,userName:String){
        @ObservedObject var userVM = UserListViewModel()
      //  @ObservedObject var userVM = UserListViewModel()//list object
        
            auth.createUser(withEmail: email,
                        password: password) { [weak self]  result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn=true
                
                //adds to user view model; VM directly adds to repo, no need for it here
                userVM.addUser(user: User(userName: userName, email: email))
                
            }
        }
        
    }
    
    func handleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()){
            [self] user, err in
            
            if let error = err {
                print(error.localizedDescription)
              return
            }

            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            
            //Firebase auth
            Auth.auth().signIn(with: credential){ result, err in
                if let error = err {
                    print(error.localizedDescription)
                  return
                }
                
                guard let user=result?.user else{
                    return
                }
                
                print(user.displayName ?? "Sucess! ")
                
            }
            
        }
        
    }

    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
        
    }
    
    func signOut(){
        try? auth.signOut()
        self.signedIn=false
    }
}
