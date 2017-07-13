//
//  TapsViewController.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/13/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class TapsViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let config = NodeConfig(width: 0.2,
                                height: 0.2,
                                length: 0.2,
                                chamferRadius: 0.0,
                                color: UIColor.red,
                                image: nil)
        let vector = SCNVector3(0.0, 0.1, -0.5)
        
        let scene = SCNScene()
        let node = Box.boxNode(forVector3: vector,
                               nodeConfig: config)
        scene.rootNode.addChildNode(node)
        
        // Set the scene to the view
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
    
    @IBAction func sceneViewTapped(_ recognizer: UITapGestureRecognizer) {
        guard let scene = recognizer.view as? SCNView else {
            return
        }
        
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = scene.hitTest(touchLocation,
                                     options: nil)
        
        if !hitResults.isEmpty {
            let node = hitResults[0].node
            let material = node.geometry?.material(named: "Color")
            
            material?.diffuse.contents = UIColor.random()
        }
    }
    
}
