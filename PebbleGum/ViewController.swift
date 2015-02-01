//
//  ViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 01/02/15.
//  Copyright (c) 2015 GoodGuys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView:UIImageView?
    var notificationBarLabel:UILabel?
    var pebbleGumLogoLabel:UILabel?
    var informationLabel:UILabel?
    var pebbleNotConnectedImage:UIImage?
    var pebbleNotConnectedImageView:UIImageView?
    var tapToConnectPebbleButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - loadView
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds // Creating a frame and taking all the space of the screen
        let view = UIView(frame: UIScreen.mainScreen().bounds) // Creating the view with the frame

        // MARK: UIImage: Background Image Configuration
        self.imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        self.imageView!.image = UIImage(named:"background.png")
        view.addSubview(self.imageView!) // Adding the background image to the view

        // MARK: Label: Notification Bar Configuration
        self.notificationBarLabel = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height/25))
        self.notificationBarLabel!.text = "Pebble not connected"
        self.notificationBarLabel!.textColor = UIColorFromRGB("d9d9d9", alpha: 1.0)
        self.notificationBarLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: frame.width/25)
        self.notificationBarLabel!.backgroundColor = UIColorFromRGB("FFFFFF", alpha: 0.12)
        self.notificationBarLabel!.textAlignment = NSTextAlignment.Center
        view.addSubview(self.notificationBarLabel!) // Adding the notification bar to the view

        // MARK: Label: PebbleGum Logo Configuration
        self.pebbleGumLogoLabel = UILabel(frame: CGRectMake(frame.width/14, frame.height/7, frame.width - frame.width/7, frame.height/10 ))
        self.pebbleGumLogoLabel!.text = "Pebble Gum"
        self.pebbleGumLogoLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: frame.width/6)
        self.pebbleGumLogoLabel!.textAlignment = NSTextAlignment.Center
        self.pebbleGumLogoLabel!.textColor = UIColorFromRGB("FFFFFF", alpha: 1.0)
        view.addSubview(self.pebbleGumLogoLabel!) // Adding the Pebble Gum logo to the view
        
        // MARK: Label: Information Label Configuration
        self.informationLabel = UILabel(frame: CGRectMake(frame.width/14, frame.height/4.5, frame.width - frame.width/7, frame.height/5 ))
        self.informationLabel!.numberOfLines = 0
        self.informationLabel!.text = "To access your data, please pair your Pebble with your iPhone."
        self.informationLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: frame.width/20)
        self.informationLabel!.textAlignment = NSTextAlignment.Center
        self.informationLabel!.textColor = UIColorFromRGB("FFFFFF", alpha: 1.0)
        view.addSubview(self.informationLabel!) // Adding the information label to the view
        
        // MARK: UIImage: Not Connected Pebble
        self.pebbleNotConnectedImage = UIImage(named: "BluePebbleWatchQuestionMark.png")
        self.pebbleNotConnectedImageView = UIImageView(image: self.pebbleNotConnectedImage!)
        let sizeOfThisImage = self.pebbleNotConnectedImage!.size
        self.pebbleNotConnectedImageView!.frame = CGRect(x: frame.width/3.3, y: frame.height/2.3, width: sizeOfThisImage.width, height: sizeOfThisImage.height)
        view.addSubview(self.pebbleNotConnectedImageView!) // Adding the Pebble not connected image to the view
        
        // MARK: UIButton: Tap To Connected Pebble Label Configuration
            // Global state
            self.tapToConnectPebbleButton = UIButton(frame: CGRectMake(frame.width/14, frame.height - frame.height/5, frame.width - frame.width/7, frame.height/12))
            self.tapToConnectPebbleButton!.setTitle("Tap to pair your iPhone", forState: UIControlState.Normal)
            self.tapToConnectPebbleButton!.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: frame.width/16)
            self.tapToConnectPebbleButton!.backgroundColor = UIColorFromRGB("FFFFFF", alpha: 0.12)
            // Normal state
            self.tapToConnectPebbleButton!.setTitleColor(UIColorFromRGB("d9d9d9", alpha: 1.0), forState: UIControlState.Normal)
            // - Highlighted state
            self.tapToConnectPebbleButton!.setTitleColor(UIColorFromRGB("ffffff", alpha: 1.0), forState: UIControlState.Highlighted)
        self.tapToConnectPebbleButton!.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchDown)
        view.addSubview(self.tapToConnectPebbleButton!)
        

        self.view = view
    }
    
    // MARK: - Hidden Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - buttonAction
    func buttonAction(send: UIButton!)
    {
        println("TapToConnectPebblButton TouchDown")
        let alert = UIAlertView()
        alert.title = "Select an accessory"
        alert.message = "Please select your Pebble from the list"
        alert.addButtonWithTitle("Cancel")
        alert.addButtonWithTitle("Ok")
        alert.show()
    }


}

