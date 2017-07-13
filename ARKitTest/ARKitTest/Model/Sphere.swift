//
//  Sphere.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/12/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import Foundation
import SceneKit

struct Sphere {
    static func sphereNode(withRadius radius: CGFloat,
                           vector: SCNVector3,
                           color: UIColor,
                           image: UIImage?) -> SCNNode {
        let sphere = SCNSphere(radius: radius)
        
        let material = SCNMaterial()
        material.diffuse.contents = image ?? color
        
        let node = SCNNode()
        node.geometry = sphere
        node.geometry?.materials = [material]
        node.position = vector
        return node
    }
}
