//
//  PlaneViewController.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/13/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlaneViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!

    var planes = [OverlayPlane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [
            ARSCNDebugOptions.showFeaturePoints,
            ARSCNDebugOptions.showWorldOrigin
        ]
        
        sceneView.delegate = self
        
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

extension PlaneViewController: ARSCNViewDelegate {
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
