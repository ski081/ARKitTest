//
//  TextDisplayViewController.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/12/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class TextDisplayViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        let textGeometry = SCNText(string: "Hello, World",
                                   extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(0.0, 0.1, -0.5)
        textNode.scale = SCNVector3(0.02, 0.02, 0.02)
        
        scene.rootNode.addChildNode(textNode)
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
