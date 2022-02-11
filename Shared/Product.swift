//
//  Product.swift
//  FindAR
//
//  Created by Dev Patel on 2/10/22.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Product: Codable {
//    var id: ObjectIdentifier
    //somthings is codable is everything inside(pritives) are codeable
    @DocumentID var productId: String? //creates a unqiue id for each task. DocumentID,tells firestore to add id to this field
    var productName: String
    var company: String
    @ServerTimestamp var createdTime: Timestamp?//whenever user timestamp is null, will create a timestamp
    var userID:String?

}

