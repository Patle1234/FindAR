//
//  Model.swift
//  FindAR
//
//  Created by Dev Patel on 2/23/22.
//

import SwiftUI
import RealityKit
import Combine
import FirebaseStorage

enum ModelCatagory: CaseIterable{
    case table
    case chair
    case decor
    case light
    
    var label:String{return "jo"}
}

class Model{
    var name: String
    var catagory: ModelCatagory
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    private var cancellable: AnyCancellable?
    
    init(name: String, catagory: ModelCatagory, scaleCompensation: Float){
        self.name=name
        self.catagory=catagory
        self.scaleCompensation=scaleCompensation
    }
    
    func asyncLoadModelEntity(){
        var fileName=self.name+".usdz"
        fileName="toy_robot_vintage.usdz"
        FirebaseStorageHelper.asyncDownloadToFilesystem(relativePath: "model/\(self.name).usdz", handler: {localUrl in
            
            
            self.cancellable=ModelEntity.loadModelAsync(contentsOf: localUrl)
                .sink(receiveCompletion: {loadCompletion in
                    switch loadCompletion{
                    case .failure(let error): print("Unable to load model. Error: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                }, receiveValue: {modelEntity in
                    self.modelEntity=modelEntity
                    self.modelEntity?.scale += self.scaleCompensation
                    
                    print("Model for\(modelEntity.name) has been loaded")
                })
            
        })
        

    }
    
    
}

struct Models{
    var all:[Model] = []
    
    init(){
        let diningTable=Model(name: "toy_robot_vintage", catagory: .table, scaleCompensation: 0.32/100)
        self.all=[diningTable]
    }
    
    func get(category: ModelCatagory) -> [Model] {
        return all.filter({$0.catagory==category})
    }
}
