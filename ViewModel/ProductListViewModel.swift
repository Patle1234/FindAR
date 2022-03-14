//
//  UserListViewModel.swift
//  FindAR
//
//  Created by Dev Patel on 2/10/22.
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject{//list of all of the tasks on the screen
    @Published var ProductCellViewModels = [ProductCellViewModel]()
    @Published var productRespository = ProductRepository()
//    @Published var ProductRecent:Product = Product(id: nil, productId: nil, productName: "", company: "", description: "", category: "")
//    @Published var productsList = []
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        productRespository.$products
            .map{products in//adding our tasks to TCVM
                products.map{product in
                    ProductCellViewModel(product: product)
            }
        }
         .assign(to: \.ProductCellViewModels,on:self)
        .store(in: &cancellable)
    }
    
    
    func addProduct(product: Product){//adds a task to the ViewModel
        print("in?")
        productRespository.addProduct(product)
        let productVM = ProductCellViewModel(product: product)
        self.ProductCellViewModels.append(productVM)
    }
//    func addProdToList(product: Product){
////        print("product")
////        print(product)
////        productsList.append(product)
////        print("array")
////        print(productsList)
//        ProductRecent = product
//    
//}
//    func returnProduct() -> Product {
//
//        return ProductRecent
//    }
//    func updateUser(user: User){
//        userRepository.updateUser(user)
//    }
//
    
    //TODO: UNCMOMENT AND FIX
//    func deleteUser(user: User){
//        userRepository.deleteUser(user)
//        let userVM = UserCellViewModel(user: user)
//        self.UserCellViewModels.removeAll{$0.id==userVM.id}
//    }
//
//    func deleteFriend(currentUser: User,otherUser:User){
//        let userVM = UserCellViewModel(user: otherUser)
//        let currentUserVM = UserCellViewModel(user: currentUser)
//
//        userVM.user.friends.removeAll{$0==currentUserVM.user.userName}
//        userRepository.updateUser(userVM.user)
//
//        currentUserVM.user.friends.removeAll{$0==userVM.user.userName}
//        userRepository.updateUser(currentUserVM.user)
//    }
}
