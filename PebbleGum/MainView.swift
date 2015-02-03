//
//  MainMenuView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 03/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var viewController: MainViewController? = nil
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // PBDataLoggingService.setDelegateQueue(self)
        
        self.backgroundColor = UIColor.blackColor()
        
        let myLabel = UILabel(frame: CGRect(x: 0.0, y: frame.size.height/2.0, width: frame.size.width, height: 30.0))
        myLabel.text = NSLocalizedString("Main_Label", comment: "")
        myLabel.textColor = UIColor.whiteColor()
        myLabel.textAlignment = .Center
        self.addSubview(myLabel)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}