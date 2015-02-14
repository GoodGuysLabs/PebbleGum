//
//  AddCredentialView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 13/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class AddCredentialView: UIView, PBPebbleCentralDelegate, UITextFieldDelegate {
    
    var viewController: AddCredentialViewController? = nil
    let imageView:UIImageView?
    let functions = theFunctions()
    var inputTitle:UITextField?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view

        // Keychain icon font
        var keychainNewIcon:UILabel! = UILabel(frame: CGRectMake(frame.width/14, frame.height/7, frame.width - frame.width/7, frame.height/10))
        keychainNewIcon.font = UIFont.fontAwesomeOfSize(frame.height/10)
        keychainNewIcon.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.7)
        keychainNewIcon.text = String.fontAwesomeIconWithName("fa-key")
        self.addSubview(keychainNewIcon)
        
        // Credential Input Title
        inputTitle = UITextField(frame: CGRectMake(frame.width - frame.width/1.5, frame.height/6, frame.width - frame.width/2.3, frame.height/14))
        inputTitle?.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputTitle?.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputTitle?.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputTitle?.leftViewMode = UITextFieldViewMode.Always
        inputTitle?.clearButtonMode = UITextFieldViewMode.WhileEditing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "myMethod", name: UITextFieldTextDidBeginEditingNotification, object: nil)
        //inputTitle?.becomeFirstResponder()
        self.addSubview(inputTitle!)
        
    }
    
    func myMethod(notification:NSNotification) {
        println(":")
        println(notification)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.endEditing(true)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}