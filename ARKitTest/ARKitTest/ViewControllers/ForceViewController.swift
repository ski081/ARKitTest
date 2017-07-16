//
//  ForceViewController.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/14/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ForceViewController: BaseSceneViewController {
    var planes = [OverlayPlane]()
    
    @IBOutlet var singleTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        sceneView.delegate = self
        sceneView.scene = scene
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
    }
    
    @IBAction func sceneWasDoubleTapped(_ recognizer: UITapGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            return
        }
        
        let touch = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touch,
                                           options: nil)
        guard !hitResults.isEmpty,
            let hitResult = hitResults.first else {
            return
        }
        
        let node = hitResult.node
        let forceMultiplier = Float(2.0)
        let vector = SCNVector3(hitResult.worldCoordinates.x * forceMultiplier,
                                forceMultiplier,
                                hitResult.worldCoordinates.z * forceMultiplier)
        node.physicsBody?.applyForce(vector,
                                     asImpulse: true)
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

extension ForceViewController: ARSCNViewDelegate {
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
