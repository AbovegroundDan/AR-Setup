//
//  MainScene.swift
//  ARTest1
//
//  Created by Daniel Wyszynski on 7/22/17.
//  Copyright © 2017 Aboveground Systems, LLC. All rights reserved.
//

import UIKit
import SceneKit

class MainScene {

    var scene: SCNScene?

    init() {
        scene = self.initializeScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        scene = self.initializeScene()
    }
    
    func initializeScene() -> SCNScene? {
        let scene = SCNScene()
        
        setDefaults(scene: scene)
        
        return scene
    }
    
    func setDefaults(scene: SCNScene) {
//        let camera = SCNCamera()
//        let cameraNode = SCNNode()
//        cameraNode.name = "__camera"
//        cameraNode.camera = camera
//        camera.zNear = 0.01
//        camera.automaticallyAdjustsZRange = true
//        scene.rootNode.addChildNode(cameraNode)
        
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light?.type = SCNLight.LightType.ambient
//        ambientLightNode.light?.color = UIColor(white: 0.6, alpha: 1.0)
//        scene.rootNode.addChildNode(ambientLightNode)
    }
    
    func addBlockToPos(position: SCNVector3, imageName: String) {
        
        guard let scene = self.scene else { return }

        let blockNode = SCNNode()
        blockNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
        blockNode.geometry?.firstMaterial?.diffuse.contents = imageName // Can either do a string for the filename, or the actual UIImage
        
        blockNode.position = position
        scene.rootNode.addChildNode(blockNode)
    }
}


