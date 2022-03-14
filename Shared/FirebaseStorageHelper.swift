//
//  FirebaseStorageHelper.swift
//  FindAR
//
//  Created by Dev Patel on 3/3/22.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseStorageHelper{
    static private let cloudStorage=Storage.storage()
    
    class func asyncDownloadToFilesystem(relativePath: String, handler: @escaping (_ fileURL:URL) -> Void){
        let docsUrl=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl=docsUrl.appendingPathComponent(relativePath)

        
        
        if(FileManager.default.fileExists(atPath: fileUrl.path)){
            handler(fileUrl)
            
            return
        }
        
        let storageRef=cloudStorage.reference(withPath: relativePath)
        
        storageRef.write(toFile: fileUrl){url, error in
            guard let localUrl=url else{
                print(error)
                print("Firebase Storage: Error Downloading file with relative path: \(relativePath)")
                return
            }
            handler(localUrl)
        }.resume()
        
        
    }
}
 
