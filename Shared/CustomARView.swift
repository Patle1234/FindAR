//
//  CustomARView.swift
//  FindAR
//
//  Created by Dev Patel on 2/23/22.
//

import RealityKit
import ARKit
import FocusEntity


class CustomARView:ARView{
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect){
        super.init(frame: frameRect)
        
        focusEntity=FocusEntity(on: self, focus: .classic)
    }
    
    @objc required dynamic init?(coder decoder: NSCoder){
        fatalError("init(:coder) hasn't been implemented")
    }
    
    private func configure(){
        let config=ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        session.run(config)
        
    }
    
    
    
}
