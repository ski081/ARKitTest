//
//  OverlayPlane.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/13/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class OverlayPlane: SCNNode {
    var anchor: ARPlaneAnchor
    var planeGeometry: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withAnchor anchor: ARPlaneAnchor) {
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
        self.position = SCNVector3Make(anchor.center.x,
                                       0,
                                       anchor.center.z)
        guard let planeNode = self.childNodes.first else {
            return
        }
        
        let shape = SCNPhysicsShape(geometry: self.planeGeometry,
                                    options: nil)
        planeNode.physicsBody = SCNPhysicsBody(type: .static,
                                               shape: shape)
    }
    
    private func setup() {
        planeGeometry = SCNPlane(width: CGFloat(self.anchor.extent.x),
                                 height: CGFloat(self.anchor.extent.z))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "overlay_grid")
        
        planeGeometry.materials = [
            material
        ]
        
        let planeNode = SCNNode(geometry: planeGeometry)
        let shape = SCNPhysicsShape(geometry: self.planeGeometry, options: nil)
        planeNode.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        planeNode.physicsBody?.categoryBitMask = BodyType.plane.rawValue

        
        planeNode.position = SCNVector3Make(anchor.center.x,
                                            0,
                                            anchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0),
                                                     1.0,
                                                     0.0,
                                                     0.0)
        self.addChildNode(planeNode)
    }
}
