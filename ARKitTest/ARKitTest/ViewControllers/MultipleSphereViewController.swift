//
//  MultipleSphereViewController.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/12/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class MultipleSphereViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let boxImage = UIImage(named: "texture-brick")
        let config = NodeConfig(width: 0.2,
                                height: 0.2,
                                length: 0.2,
                                chamferRadius: 0.0,
                                color: UIColor.red,
                                image: boxImage)
        let vector = SCNVector3(0.0, 0.1, -0.5)
        
        let scene = SCNScene()
        let node = Box.boxNode(forVector3: vector,
                               nodeConfig: config)
        scene.rootNode.addChildNode(node)
        
        let sphereVector = SCNVector3(0.5, 0.1, -1)
        let image = UIImage(named: "texture-earth")
        let sphereNode = Sphere.sphereNode(withRadius: 0.2,
                                           vector: sphereVector,
                                           color: UIColor.green, image: image)
        scene.rootNode.addChildNode(sphereNode)
        
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
}
