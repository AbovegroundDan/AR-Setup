//
//  ViewController.swift
//  tutorial1
//
//  Created by Wyszynski, Daniel on 7/28/17.
//  Copyright © 2017 Wyszynski, Daniel. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var sessionConfig: ARWorldTrackingSessionConfiguration = ARWorldTrackingSessionConfiguration()
    var sceneController = MainScene()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Add a tap gesture recognizer to the view. You could also override touchesBegan and do it there, but lets stick to what's normal to iOS app devs
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTap))
        sceneView.addGestureRecognizer(tap)

        if let scene = sceneController.scene {
            // Set the scene to the view
            sceneView.scene = scene
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Run the view's session
        sceneView.session.run(sessionConfig)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - Gesture delegates
    var currentTexture = 0
    @objc func didTap(_ sender:UITapGestureRecognizer) {
        let location = sender.location(in: sceneView)
        
        guard let frame = sceneView.session.currentFrame else {
            return
        }

        let cameraPos = SCNVector3.positionFromTransform(frame.camera.transform)
 
        // Note: z: 1.0 will unproject() the screen position to the far clipping plane.
        let positionVec = SCNVector3(x: Float(location.x), y: Float(location.y), z: 1.0)
        let screenPosOnFarClippingPlane = self.sceneView.unprojectPoint(positionVec)

        let rayDirection = screenPosOnFarClippingPlane - cameraPos
        let rayMult = (rayDirection / 1000.0) / 5
        
        let blockTextures = ["WoodCubeA.jpg", "WoodCubeB.jpg", "WoodCubeC.jpg"]
        let randTexture = blockTextures[currentTexture % blockTextures.count]
        currentTexture += 1
        sceneController.addBlockToPos(position: rayMult + cameraPos, imageName: "art.scnassets/" + randTexture)
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
