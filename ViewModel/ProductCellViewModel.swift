//
//  ProductCellViewModel.swift
//  FindAR
//
//  Created by user212286 on 2/11/22.
//



import Foundation
import Combine

class ProductCellViewModel: ObservableObject, Identifiable{
    @Published var productRepo=ProductRepository()
    @Published var product: Product
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
        ProductCellViewModel(product: Product(productName: "", company: "", description: "", category: ""))
    }
    

}
