//
//  CollisionDetectionViewController.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/13/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class CollisionDetectionViewController: BaseSceneViewController {
    var planes = [OverlayPlane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        sceneView.delegate = self
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    @IBAction func sceneWasTapped(_ recognizer: UITapGestureRecognizer) {
        guard let scene = recognizer.view as? ARSCNView else {
            return
        }
        
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = scene.hitTest(touchLocation,
                                       types: .existingPlaneUsingExtent)
        
        if !hitResults.isEmpty {
            guard let hitTestResult = hitResults.first else {
                return
            }
            
            addBox(forHitResult: hitTestResult)
        }
    }
    
    private func addBox(forHitResult hitResult: ARHitTestResult) {
        let config = NodeConfig(width: 0.2,
                                height: 0.2,
                                length: 0.1,
                                chamferRadius: 0.0,
                                color: .red,
                                image: nil)
        
        let vector = SCNVector3(hitResult.worldTransform.columns.3.x,
                                hitResult.worldTransform.columns.3.y + Float(0.5),
                                hitResult.worldTransform.columns.3.z)
        let boxNode = Box.boxNode(forVector3: vector,
                                  nodeConfig: config)
        boxNode.physicsBody = SCNPhysicsBody(type: .dynamic,
                                             shape: nil)
        boxNode.categoryBitMask = BodyType.box.rawValue
        boxNode.position = vector
        sceneView.scene.rootNode.addChildNode(boxNode)
    }

}

extension CollisionDetectionViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        
        let plane = OverlayPlane(anchor: planeAnchor)
        planes.append(plane)
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        let plane = planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
            }.first
        
        if let plane = plane,
            let anchor = anchor as? ARPlaneAnchor {
            plane.update(withAnchor: anchor)
        }
    }
}
