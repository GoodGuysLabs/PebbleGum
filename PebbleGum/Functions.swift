//
//  Functions.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 01/02/15.
//  Copyright (c) 2015 GoodGuys. All rights reserved.
//

import Foundation
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