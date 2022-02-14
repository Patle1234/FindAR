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

class ProductRepository: ObservableObject{
    let database = Firestore.firestore()
    @Published var products=[Product]()
    
    //TODO: prob need this, not using for now tho
//    @Published var cProduct=[Product]()

    init(){
        loadData()
        
        //TODO: UNCOMMENT AND FIX
//        getUser()
    }
    
    
    func loadData(){
//        let userID=Auth.auth().currentUser?.uid
        database.collection("products")
            .addSnapshotListener{(querySnapshot,error) in //calling the collection and getting a snapshot
            if let querySnapshot = querySnapshot{
                self.products=querySnapshot.documents.compactMap{ document in
                    do{
                        let x=try document.data(as: Product.self)
                        return x
                    }catch{
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    
    func addProduct(_ product:Product ){
        do{
           var addedProduct=product
//            addedProduct.productId=Auth.auth().currentUser?.uid
           let _=try database.collection("products").addDocument(from: addedProduct)//from: addedTask
        }catch{
            fatalError("unable to encode products\(error.localizedDescription)")
        }
    }
  
    
    //TODO: UNCOMMENT AND FIX
//    func getProduct(){
//        let userID=Auth.auth().currentUser?.uid
//        database.collection("users")
//            .whereField("userId", isEqualTo:userID)
//            .addSnapshotListener{(querySnapshot,error) in //calling the collection and getting a snapshot
//            if let querySnapshot = querySnapshot{
//                self.cUser=querySnapshot.documents.compactMap{ document in
//                    do{
//                        let x=try document.data(as: User.self)
//                        return x
//                    }catch{
//                        print(error)
//                    }
//                    return nil
//                }
//            }
//        }
//    }
    
    
//    func updateUser(_ user:User){
//        if let userID=user.id{
//            do{
//                try database.collection("users").document(userID).setData(from: user)
//            }catch{
//                print(error)
//            }
//        }
//    }
    
    
    
    //TODO: UNCOMMENT AND FIX
//    func deleteUser(_ user:User){
//        if let userID=user.id{
//            do{
//                print("will delete")
//                try database.collection("users").document(userID).delete()
//            }catch{
//                print(error)
//            }
//        }
//    }

    
    
    
}
