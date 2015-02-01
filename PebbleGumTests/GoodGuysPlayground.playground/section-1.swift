// Playground - noun: a place where people can play

import UIKit

func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
    var scanner = NSScanner(string:colorCode)
    var color:UInt32 = 0;
    scanner.scanHexInt(&color)
    
    let mask = 0x000000FF
    let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
    let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
    let b = CGFloat(Float(Int(color) & mask)/255.0)
    
    return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
}

var myLabel:UILabel?

myLabel?.textColor = UIColorFromRGB("bb0000", alpha: 1.0)

let frame = UIScreen.mainScreen().bounds // Creating a frame and taking all the space of the screen
let view = UIView(frame: UIScreen.mainScreen().bounds) // Creating the view with the frame

// MARK: — PebbleGum Logo Configuration
myLabel = UILabel(frame: CGRectMake(frame.width/3.0, 0, 100, 100))