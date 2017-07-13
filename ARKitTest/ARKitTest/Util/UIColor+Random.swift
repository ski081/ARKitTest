//
//  UIColor+Random.swift
//  ARKitTest
//
//  Created by Struzinski, Mark - Mark on 7/13/17.
//  Copyright © 2017 mstruzinski. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(displayP3Red: .random(),
                       green: .random(),
                       blue: .random(),
                       alpha: .random())
    }
}
