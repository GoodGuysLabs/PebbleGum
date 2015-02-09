//
//  MainMenuView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 03/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class MainView: UIView, PBPebbleCentralDelegate {
    
    var viewController: MainViewController? = nil
    let functions = theFunctions()
    let imageView:UIImageView?
    let pebbleGumLogoLabel:UILabel?
    var informationLabel:UILabel?
    var pebbleNotConnectedImageView:UIImageView?
    var pebbleNotConnectedImage:UIImage?
    var tapToRecheckPebbleConnection:UIButton?

    override init(frame: CGRect)
    {
        super.init(frame: frame)

        // MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view
        
        // MARK: Label: PebbleGum Logo Configuration
        pebbleGumLogoLabel = UILabel(frame: CGRectMake(frame.width/14, frame.height/7, frame.width - frame.width/7, frame.height/10 ))
        pebbleGumLogoLabel!.text = NSLocalizedString("PebbleGum_Logo", comment: "Pebble Gum Logo")
        pebbleGumLogoLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: frame.width/6)
        pebbleGumLogoLabel!.textAlignment = NSTextAlignment.Center
        pebbleGumLogoLabel!.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 1.0)
        self.addSubview(pebbleGumLogoLabel!) // Adding the Pebble Gum logo to the view
        
        // MARK: Label: Information Label Configuration
        informationLabel = UILabel(frame: CGRectMake(frame.width/14, frame.height/4.5, frame.width - frame.width/7, frame.height/5 ))
        informationLabel!.numberOfLines = 0
        informationLabel!.text = NSLocalizedString("Data_Access_Pair_Pebble", comment: "Access data message if no Pebble watch is connected")
        informationLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: frame.width/20)
        informationLabel!.textAlignment = NSTextAlignment.Center
        informationLabel!.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 1.0)
        self.addSubview(informationLabel!) // Adding the information label to the view
        
        // MARK: UIImage: Not Connected Pebble
        pebbleNotConnectedImage = UIImage(named: "BluePebbleWatchQuestionMark.png")
        pebbleNotConnectedImageView = UIImageView(image: self.pebbleNotConnectedImage!)
        let sizeOfThisImage = pebbleNotConnectedImage!.size
        pebbleNotConnectedImageView!.frame = CGRect(x: frame.width/3.3, y: frame.height/2.3, width: sizeOfThisImage.width, height: sizeOfThisImage.height)
        self.addSubview(pebbleNotConnectedImageView!) // Adding the Pebble not connected image to the view
        
        // MARK: UIButton: Tap To Connected Pebble Label Configuration
            // Global state
            tapToRecheckPebbleConnection = UIButton(frame: CGRectMake(frame.width/14, frame.height - frame.height/5, frame.width - frame.width/7, frame.height/12))
            tapToRecheckPebbleConnection!.setTitle(NSLocalizedString("Recheck_Pebble_Connection", comment: "Button to recheck Pebble connection"), forState: UIControlState.Normal)
            tapToRecheckPebbleConnection!.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: frame.width/16)
            tapToRecheckPebbleConnection!.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
            // Normal state
            tapToRecheckPebbleConnection!.setTitleColor(functions.UIColorFromRGB("d9d9d9", alpha: 1.0), forState: UIControlState.Normal)
            // Highlighted state
            tapToRecheckPebbleConnection!.setTitleColor(functions.UIColorFromRGB("ffffff", alpha: 1.0), forState: UIControlState.Highlighted)
            tapToRecheckPebbleConnection!.addTarget(self, action: "checkBTConnectionAction:", forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(tapToRecheckPebbleConnection!)
    }
    
    // MARK: - Check Bluetooth Connection action
    func checkBTConnectionAction(send: UIButton!)
    {

        println("checkBTConnectionAction: TouchDown")
        
        var checkIt = functions.checkPebbleIsConnected()

        if (checkIt[2] == "2") {
            let isConnected = JSSAlertView().success(viewController!, title: NSLocalizedString("PebbleConnectedTitle", comment: "Alert UI title when the Pebble is connected after tapping the button"), text: NSLocalizedString("PebbleConnectedMessage", comment: "Alert UI message when the Pebble is connected after tapping the button"))
            isConnected.addAction({ () -> Void in
                var afterConnectViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
                self.viewController?.navigationController?.pushViewController(afterConnectViewController, animated: true)
            })
        } else {
            let stillNotConnected = JSSAlertView().danger(viewController!, title: NSLocalizedString("PebbleStillNotConnectedTitle", comment: ""), text: NSLocalizedString("PebbleStillNotConnectedMessage", comment: ""))
        }

    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}