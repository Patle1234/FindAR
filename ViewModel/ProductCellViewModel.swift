//
//  ProductCellViewModel.swift
//  FindAR
//
//  Created by user212286 on 2/11/22.
//



import Foundation
import Combine
import UIKit

class ProductCellViewModel: ObservableObject, Identifiable{
    @Published var productRepo=ProductRepository()
    @Published var product: Product
//    @Published var thumbnail:UIImage
//    @Published var model:
    var id:String = ""
    private var cancellable = Set<AnyCancellable>()
    var ifCompletedIcon: String = ""
    
    init(product: Product){
        self.product=product
        
        $product
            .compactMap{product in
                product.id
            }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
    }
    static func newTask() -> ProductCellViewModel {
        ProductCellViewModel(product: Product(productName: "", company: "", description: "", category: "",imageName:"",usdzName:""))//TODO: Add model and thumbnail
    }
    

}
