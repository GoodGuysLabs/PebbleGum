//
//  Functions.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 01/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import Foundation
import UIKit

class theFunctions: UIView, PBPebbleCentralDelegate {

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

    func checkPebbleIsConnected() -> Dictionary<Int, String>
    {
        var code = Dictionary<Int, String>()
        
        let defaultCentral: PBPebbleCentral = PBPebbleCentral.defaultCentral()
        defaultCentral.delegate = self
        
        if (( defaultCentral.lastConnectedWatch() ) != nil) {
            if (defaultCentral.lastConnectedWatch().connected) {
                code[2] = "2"
            } else {
                code[1] = "1"
            }
        } else {
            code[0] = "0"
        }
        
        return code
    }
    
    func pebbleInfos() -> AnyObject
    {
        var pebbleInformations: AnyObject
        var pebbleCheck = self.checkPebbleIsConnected()
        
        if (pebbleCheck[2] == "2") {
            let defaultCentral: PBPebbleCentral = PBPebbleCentral.defaultCentral()
            defaultCentral.delegate = self
            pebbleInformations = defaultCentral.lastConnectedWatch()
        } else {
            pebbleInformations = "Error 1"
        }
        
        return pebbleInformations
    }
    
    func addCredential() -> AnyObject
    {
        return ":)"
        
    }
    
}