//
//  ParallaxController.swift
//  Parallax Lib
//
//  Created by Joseph on 06/10/2014.
//  Copyright (c) 2014 Swift London. All rights reserved.
//

import UIKit
import Foundation
import CoreMotion
//import math

private struct ParallaxObject {
    let object : UIView
    var  zPosition : CGFloat
}

public class ParallaxController : AttitudeManagerDelegate {
    //private var devicePos =  CMDeviceMotion()
    var currentPitch:CGFloat = 0
    var currentRoll:CGFloat = 0
    private var objects = [ParallaxObject]()
    private let attitudeMan: AttitudeManager = AttitudeManager.sharedInstance
    init() {
        attitudeMan.delegate = self
        attitudeMan.start()
    }
    
    public func didReceiveMotionUpdate(roll: Double, pitch: Double, yaw: Double) {
        if(CGFloat(roll) != currentRoll || CGFloat(pitch) != currentPitch) {
            dispatch_async(dispatch_get_main_queue()) {
                self.currentPitch = CGFloat(pitch)
                self.currentRoll  = CGFloat(roll)
                self.updateAllTransforms() }
        }
    }
    
    public func addObject(object:UIView, zPosition: CGFloat) {
        let po = ParallaxObject(object: object, zPosition:zPosition)
        objects.append(po)
        self.updateTransform(po)
    }
    
    private func updateTransform(po:ParallaxObject) {
        //        var cappedPitch = max(pitch, 0.25*M_PI)
        let transform = CGAffineTransformMakeTranslation(currentRoll * po.zPosition, currentPitch * po.zPosition)
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