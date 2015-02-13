//
//  TrousseauView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 13/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class TrousseauView: UIView, PBPebbleCentralDelegate {
    
    var viewController: TrousseauViewController? = nil
    let imageView:UIImageView?
    let functions = theFunctions()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view
        
        // MARK: UIImage: Not Connected Pebble
        var pebbleNotConnectedImage = UIImage(named: "LightLogoWithoutBG&Text.png")
        var pebbleNotConnectedImageView = UIImageView(image: pebbleNotConnectedImage)
        let sizeOfThisImage = pebbleNotConnectedImage!.size
        let scaleFactor = frame.width / sizeOfThisImage.width
        let newHeight = sizeOfThisImage.height * scaleFactor
        pebbleNotConnectedImageView.frame = CGRect(x: (frame.width - frame.width/3)/2, y: 120.0, width: frame.width/3, height: newHeight/3)
        self.addSubview(pebbleNotConnectedImageView) // Adding the Pebble not connected image to the view
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}