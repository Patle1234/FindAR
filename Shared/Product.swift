//
//  Product.swift
//  FindAR
//
//  Created by Dev Patel on 2/10/22.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

public struct Product: Codable {
//    var id: ObjectIdentifier
    //somthings is codable is everything inside(pritives) are codeable
    @DocumentID var id: String? //creates a unqiue id for each task. DocumentID,tells firestore to add id to this field
    var productId:String?
    var productName: String
    var company: String
    var description: String
    var category: String
//    var usdz: String
    //TODO: FIGURE OUT IMAGE
//    var image:
//    @ServerTimestamp var createdTime: Timestamp?//whenever user timestamp is null, will create a timestamp

}



//


 
