//
//  SignIn.swift
//  FindAR
//
//  Created by Dev Patel on 2/4/22.
//

import Foundation
import FirebaseAuth
import SwiftUI


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
        @ObservedObject var userRepo = UserRepository()
      //  @ObservedObject var userViewModel()//list object
        
            auth.createUser(withEmail: email,
                        password: password) { [weak self]  result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn=true
                //TODO: THIS CODE IS WHEN You SIGN UP A PERSON
                userRepo.addUser(User(userName: userName, email: email))
                
                
            }
        }
        
    }


    
    func signOut(){
        try? auth.signOut()
        self.signedIn=false
    }
}
