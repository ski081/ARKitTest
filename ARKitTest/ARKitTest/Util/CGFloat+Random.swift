//
//  CGFloat+Random.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/13/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
