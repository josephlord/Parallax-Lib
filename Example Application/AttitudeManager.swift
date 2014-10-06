//
//  AttitudeManager.swift
//  Parallax Lib
//
//  Created by Tai Heng on 2014/10/6.
//  Copyright (c) 2014 Swift London. All rights reserved.
//

import Foundation
import CoreMotion

protocol AttitudeManagerDelegate {
    func didReceiveMotionUpdate(motion: CMDeviceMotion)
}

class AttitudeManager
{
    var motionManager: CMMotionManager!
    var delegate: AttitudeManagerDelegate!
    var updateInterval = 0.1
    
    init() {
        motionManager = CMMotionManager()
    }
    
    func start() {
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {
            motion, error in
            if let deviceMotion: CMDeviceMotion = motion
            {
                if let unwrappedDelegate: AttitudeManagerDelegate = self.delegate
                {
                    unwrappedDelegate.didReceiveMotionUpdate(motion)
                }
            }
        })
    }
    
    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    class var sharedInstance : AttitudeManager {
    struct Static {
        static let instance : AttitudeManager = AttitudeManager()
        }
        return Static.instance
    }
}