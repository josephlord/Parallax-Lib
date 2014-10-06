//
//  ParallaxController.swift
//  Parallax Lib
//
//  Created by Joseph on 06/10/2014.
//  Copyright (c) 2014 Swift London. All rights reserved.
//

import UIKit
import Foundation
//import math

private struct ParallaxObject {
    let object : UIView
    var  zPosition : CGFloat
}


let roll:CGFloat = 0.3
let pitch:CGFloat = 0.8

public class ParallaxController {
    private var objects = [ParallaxObject]()
    
    public func addObject(object:UIView, zPosition: CGFloat) {
        let po = ParallaxObject(object: object, zPosition:zPosition)
        objects.append(po)
        self.updateTransform(po)
    }
    
    private func updateTransform(po:ParallaxObject) {
        //        var cappedPitch = max(pitch, 0.25*M_PI)
        
        let transform = CGAffineTransformMakeTranslation(roll * po.zPosition, pitch * po.zPosition)
        po.object.transform = transform
    }
    
    public func updateAllTransforms() {
        objects.map() { self.updateTransform($0) }
    }
}

// Tilt back -> front image up, back image down
// Pitch is y
// Roll is x
// Ignore yaw.