//
//  User.swift
//  FindAR
//
//  Created by Dev Patel on 2/10/22.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


struct User: Codable {
    @DocumentID var id: String? //creates a unqiue id for each task. DocumentID,tells firestore to add id to this field
    var userId:String?
    var userName:String?
    var email:String?
    //TODO: ADD all of the save items lists
}
