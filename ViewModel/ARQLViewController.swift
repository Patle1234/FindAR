//
//  ARQLViewController.swift
//  FindAR
//
//  Created by Dev Patel on 3/1/22.
//

import UIKit
import QuickLook
import ARKit
import FirebaseStorage


class ARQLViewController: UIViewController, QLPreviewControllerDataSource {
    var assetName:URL
    let assetType = "usdz"
    let allowsContentScaling = true
//    @State private var imageURL = URL(string: "")
//    let canonicalWebPageURL = URL(string: "https://github.com/ynagatomo/ARQLSanta")
    
    
    
    init(assetName: URL?=nil){

        self.assetName=assetName!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        self.assetName = URL(fileURLWithPath: "")

    }

    override func viewDidAppear(_ animated: Bool) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: false, completion: nil)
    }

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        
//        guard let path = Bundle.main.path(forResource: assetName, ofType: assetType) else {
//            fatalError("Couldn't find the supported asset file.")
//        }
//
        print("ASSESTNAME: \(assetName)")
        
//        var url = URL(fileURLWithPath:assetName)
            
        let previewItem = ARQuickLookPreviewItem(fileAt: URL(string:"https://firebasestorage.googleapis.com/v0/b/findar-4a4c0.appspot.com/o/models%2FAirForce.usdz?alt=media&token=d16553ac-abe9-41b4-a388-67b7429e68ae")!)
        previewItem.allowsContentScaling = allowsContentScaling // default = true
//        previewItem.canonicalWebPageURL = canonicalWebPageURL   // default = nil
        
        return previewItem
    }
    
    
    

    
//    func getUSDZ(name:String){
////        var url=URL
//        FirebaseStorageHelper.asyncDownloadToFilesystem(relativePath: "models/\(name).usdz", handler: {localUrl,error in
//            print("localUrl: \(localUrl)")
//            print("error: \(error)")
////            var url=URL(fileURLWithPath: localUrl)
////            pathName=localUrl
////            return URL
////             return localUrl
////             localUrl
//            
//            
//            
//    //        self.cancellable=ModelEntity.loadModelAsync(contentsOf: localUrl)
//    //            .sink(receiveCompletion: {loadCompletion in
//    //                switch loadCompletion{
//    //                case .failure(let error): print("Unable to load model. Error: \(error.localizedDescription)")
//    //                case .finished:
//    //                    break
//    //                }
//    //            }, receiveValue: {modelEntity in
//    //                self.modelEntity=modelEntity
//    //                self.modelEntity?.scale += self.scaleCompensation
//    //
//    //                print("Model for\(modelEntity.name) has been loaded")
//    //            })
//            
//        })
//    }

}
