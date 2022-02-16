//
//  UseRepository.swift
//  FindAR
//
//  Created by Dev Patel on 2/10/22.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject{
    let database = Firestore.firestore()
    @Published var users=[User]()
    @Published var cUser=[User]()

    init(){
        loadData()
        getUser()
    }
    
    
    func loadData(){
        let userID=Auth.auth().currentUser?.uid
        database.collection("users")
            .addSnapshotListener{(querySnapshot,error) in //calling the collection and getting a snapshot
            if let querySnapshot = querySnapshot{
                self.users=querySnapshot.documents.compactMap{ document in
                    do{
                        let x=try document.data(as: User.self)
                        return x
                    }catch{
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    
    func addUser(_ user:User ){
        do{
           var addedUser=user
            addedUser.userId=Auth.auth().currentUser?.uid
           let _=try database.collection("users").addDocument(from: addedUser)//from: addedTask
        }catch{
            fatalError("unable to encode users\(error.localizedDescription)")
        }
    }
    
    func getUser(){
        let userID=Auth.auth().currentUser?.uid
        database.collection("users")
            .whereField("userId", isEqualTo:userID)
            .addSnapshotListener{(querySnapshot,error) in //calling the collection and getting a snapshot
            if let querySnapshot = querySnapshot{
                self.cUser=querySnapshot.documents.compactMap{ document in
                    do{
                        let x=try document.data(as: User.self)
                        return x
                    }catch{
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    
//    func updateUser(_ user:User){
//        if let userID=user.id{
//            do{
//                try database.collection("users").document(userID).setData(from: user)
//            }catch{
//                print(error)
//            }
//        }
//    }
    
    
    
    func deleteUser(_ user:User){
        if let userID=user.id{
            do{
                print("will delete")
                try database.collection("users").document(userID).delete()
            }catch{
                print(error)
            }
        }
    }

    
    
    
}
