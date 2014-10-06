//
//  ViewController.swift
//  Example Application
//
//  Created by Joseph on 06/10/2014.
//  Copyright (c) 2014 Swift London. All rights reserved.
//

import UIKit
//import ParallaxLib

class ViewController: UIViewController {

    @IBOutlet var redView: UIView!
    @IBOutlet var blueView: UIView!
    let parallaxCont = ParallaxController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parallaxCont.addObject(redView, zPosition: -20)
        parallaxCont.addObject(blueView, zPosition: 20)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

