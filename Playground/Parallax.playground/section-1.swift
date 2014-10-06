// Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"

var view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

var redView = UIView(frame: CGRect(x: 70, y: 100, width: 100, height: 60))

redView.backgroundColor = UIColor.redColor()
var blueView = UIView(frame: CGRect(x: 200, y: 90, width: 300, height: 40))
blueView.backgroundColor = UIColor.blueColor()
view.addSubview(redView)
view.addSubview(blueView)
XCPShowView("theView", view)

var transform1 = CGAffineTransformMakeTranslation(100
    , 20)

redView.transform = transform1
