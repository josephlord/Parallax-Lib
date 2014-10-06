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
    func didReceiveMotionUpdate(roll: Double, pitch: Double, yaw: Double)
}

class AttitudeManager
{
    var motionManager: CMMotionManager!
    var delegate: AttitudeManagerDelegate!
    var updateInterval = 0.1
    var rawRoll = [0.0, 0.0, 0.0, 0.0, 0.0]
    var rawYaw = [0.0, 0.0, 0.0, 0.0, 0.0]
    var rawPitch = [0.0, 0.0, 0.0, 0.0, 0.0]
    var averageRoll = 0.0
    var averageYaw = 0.0
    var averagePitch = 0.0
    
    init() {
        motionManager = CMMotionManager()
    }
    
    func start() {
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {
            motion, error in
            if let deviceMotion: CMDeviceMotion = motion
            {
                self.smoothedRoll(deviceMotion.attitude.roll)
                self.smoothedPitch(deviceMotion.attitude.pitch)
                self.smoothedYaw(deviceMotion.attitude.yaw)
                if let unwrappedDelegate: AttitudeManagerDelegate = self.delegate
                {
                    unwrappedDelegate.didReceiveMotionUpdate(self.averageRoll, pitch: self.averagePitch, yaw: self.averageYaw)
                }
            }
        })
    }
    
    func smoothedRoll(roll:Double){
        averageRoll += roll / 5.0
        averageRoll -= rawRoll[0] / 5.0
        rawRoll.removeAtIndex(0)
        rawRoll.append(roll)
    }
    
    func smoothedYaw(yaw: Double){
        averageYaw += yaw / 5.0
        averageYaw -= rawYaw[0] / 5.0
        rawYaw.removeAtIndex(0)
        rawYaw.append(yaw)
    }
    
    func smoothedPitch(pitch: Double){
        averagePitch += pitch / 5.0
        averagePitch -= rawPitch[0] / 5.0
        rawPitch.removeAtIndex(0)
        rawPitch.append(pitch)
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