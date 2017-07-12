//
//  Box.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/12/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import Foundation
import SceneKit

struct Box {
    static func boxNode(forVector3 vector: SCNVector3, nodeConfig: NodeConfig, color: UIColor) -> SCNNode {
        let box = SCNBox(width: nodeConfig.width,
                         height: nodeConfig.height,
                         length: nodeConfig.length,
                         chamferRadius: nodeConfig.chamferRadius)

        let material = SCNMaterial()
        material.diffuse.contents = color
        
        let node = SCNNode()
        node.geometry = box
        node.geometry?.materials = [material]
        node.position = vector
        
        return node
    }
}
