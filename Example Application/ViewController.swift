//
//  ViewController.swift
//  Example Application
//
//  Created by Joseph on 06/10/2014.
//  Copyright (c) 2014 Swift London. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, AttitudeManagerDelegate {

    @IBOutlet var rotX: UILabel!
    @IBOutlet var rotY: UILabel!
    @IBOutlet var rotZ: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        AttitudeManager.sharedInstance.delegate = self
        AttitudeManager.sharedInstance.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func didReceiveMotionUpdate(motion: CMDeviceMotion) {
        rotX.text = "\(motion.attitude.roll)"
        rotY.text = "\(motion.attitude.pitch)"
        rotZ.text = "\(motion.attitude.yaw)"
    }
}

