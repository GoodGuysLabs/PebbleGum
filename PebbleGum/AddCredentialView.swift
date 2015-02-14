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
    var displayLabel:UILabel!
    var inputTitle:FloatLabelTextField?
    var inputEmail:FloatLabelTextField?
    var inputPassword:FloatLabelTextField?
    var inputNotes:UITextView?
    
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "TextDidBeginEditing:", name: UITextFieldTextDidBeginEditingNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "TextDidEndEditing:", name: UITextFieldTextDidEndEditingNotification, object: nil)
        
        // Credential Input Title
        inputTitle = FloatLabelTextField(frame: CGRectMake(frame.width - frame.width/1.5, frame.height/6, frame.width - frame.width/2.3, frame.height/14))
        inputTitle?.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputTitle", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputTitle?.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputTitle?.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputTitle?.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputTitle?.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputTitle?.leftViewMode = UITextFieldViewMode.Always
        inputTitle?.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputTitle?.keyboardAppearance = .Dark
        self.addSubview(inputTitle!)
        
        // Credential Input Email/Username
        inputEmail = FloatLabelTextField(frame: CGRectMake(frame.width/14, frame.height/3, frame.width - frame.width/6, frame.height/14))
        inputEmail?.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputLogin", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputEmail?.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputEmail?.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputEmail?.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputEmail?.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputEmail?.leftViewMode = UITextFieldViewMode.Always
        inputEmail?.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputEmail?.autocapitalizationType = .None
        inputEmail?.autocorrectionType = .No
        inputEmail?.keyboardType = .EmailAddress
        inputEmail?.keyboardAppearance = .Dark
        self.addSubview(inputEmail!)
        
        // Credential Input Password
        inputPassword = FloatLabelTextField(frame: CGRectMake(frame.width/14, frame.height/2.2, frame.width - frame.width/6, frame.height/14))
        inputPassword?.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputPassword", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputPassword?.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputPassword?.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputPassword?.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputPassword?.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputPassword?.leftViewMode = UITextFieldViewMode.Always
        inputPassword?.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputPassword?.autocapitalizationType = .None
        inputPassword?.autocorrectionType = .No
        inputPassword?.keyboardAppearance = .Dark
        inputPassword?.secureTextEntry = true
        inputPassword?.tag = 3
        self.addSubview(inputPassword!)
        
        // Credential Input Notes
        inputNotes = UITextView(frame: CGRectMake(frame.width/14, frame.height/1.65, frame.width - frame.width/6, frame.height/7))
        inputNotes?.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputNotes?.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputNotes?.keyboardAppearance = .Dark
        inputNotes?.tag = 4
        self.addSubview(inputNotes!)
    }

    func TextDidBeginEditing(sender: AnyObject) {

        let theTextField:FloatLabelTextField = sender.object! as FloatLabelTextField
        let thePlaceholder = theTextField.placeholder
        
        theTextField.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        theTextField.textColor = theFunctions().UIColorFromRGB("46474f")
        theTextField.attributedPlaceholder = NSAttributedString(string: thePlaceholder!, attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("434553", alpha: 0.8)])
        theTextField.titleActiveTextColour = theFunctions().UIColorFromRGB("434553", alpha: 0.5)

        if (theTextField.tag == 3) {
            theTextField.secureTextEntry = false
        }
        
    }
    
    func TextDidEndEditing(sender: AnyObject) {
        
        let theTextField:FloatLabelTextField = sender.object! as FloatLabelTextField
        let thePlaceholder = theTextField.placeholder
        
        theTextField.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        theTextField.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        theTextField.attributedPlaceholder = NSAttributedString(string: thePlaceholder!, attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        theTextField.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        
        if (theTextField.tag == 3) {
            theTextField.secureTextEntry = true
        }
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.endEditing(true)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}