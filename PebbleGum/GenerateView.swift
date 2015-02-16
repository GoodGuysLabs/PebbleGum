//
//  GenerateView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 15/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class GenerateView: UIView {
    
    var viewController: GenerateViewController? = nil
    var imageView:UIImageView!
    var generateLabel:UILabel!
    var inputPassword:FloatLabelTextField!
    var inputLenght:FloatLabelTextField!
    var generatePasswordButton:UIButton!
    var copyPasswordButton:UIButton!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        //MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view
        
        // MARK: Label: Keychain Configuration
        generateLabel = UILabel(frame: CGRectMake(frame.width/14, frame.height/7, frame.width - frame.width/7, frame.height/10 ))
        generateLabel.text = NSLocalizedString("Generate", comment: "")
        generateLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: frame.width/6)
        generateLabel.textAlignment = NSTextAlignment.Center
        generateLabel.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 1.0)
        self.addSubview(generateLabel) // Adding the Pebble Gum logo to the view
        
        // Password Input
        inputPassword = FloatLabelTextField(frame: CGRectMake(self.frame.width/14, self.frame.height/2.5, self.frame.width - self.frame.width/3, self.frame.height/12))
        inputPassword.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("GeneratePasswordInput", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)])
        inputPassword.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputPassword.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputPassword.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputPassword.leftView = UIView(frame: CGRectMake(0, 0, 15, 20))
        inputPassword.leftViewMode = UITextFieldViewMode.Always
        inputPassword.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputPassword.autocapitalizationType = .None
        inputPassword.autocorrectionType = .No
        inputPassword.textAlignment = .Center
        inputPassword.keyboardAppearance = .Dark
        self.addSubview(inputPassword)
        
        // Length Input
        inputLenght = FloatLabelTextField(frame: CGRectMake(inputPassword.frame.width + 30, self.frame.height/2.5, self.frame.width - inputPassword.frame.width - 50, self.frame.height/12))
        inputLenght.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("LengthInput", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)])
        inputLenght.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputLenght.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputLenght.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
//        inputLenght.leftView = UIView(frame: CGRectMake(0, 0, 15, 20))
//        inputLenght.leftViewMode = UITextFieldViewMode.Always
//        inputLenght.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputLenght.autocapitalizationType = .None
        inputLenght.autocorrectionType = .No
        inputLenght.textAlignment = .Center
        inputLenght.keyboardType = .DecimalPad
        inputLenght.keyboardAppearance = .Dark
        inputLenght.text = "8"
        self.addSubview(inputLenght)
        
        // Copy Password Button
        copyPasswordButton = UIButton(frame: CGRectMake(self.frame.width/14, self.frame.height/1.5, self.frame.width - self.frame.width/2 - 10, self.frame.height/15))
        copyPasswordButton.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        copyPasswordButton.setTitle(String(format: NSLocalizedString("CopyPasswordButton", comment: "")), forState: .Normal)
        copyPasswordButton.setTitleColor(theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8), forState: UIControlState.Normal)
        copyPasswordButton.addTarget(self, action: "copyPassword:", forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(copyPasswordButton)
        
        // Password Generate Button
        generatePasswordButton = UIButton(frame: CGRectMake(copyPasswordButton.frame.width + self.frame.width/14 + 10, self.frame.height/1.5, self.frame.width - self.frame.width/14 - copyPasswordButton.frame.width - 30, self.frame.height/15))
        generatePasswordButton.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        generatePasswordButton.setTitle(String(format: NSLocalizedString("GeneratePasswordButton", comment: "")), forState: .Normal)
        generatePasswordButton.setTitleColor(theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8), forState: UIControlState.Normal)
        generatePasswordButton.addTarget(self, action: "generatePassword:", forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(generatePasswordButton)
    }
    
    func generatePassword(sender: UIButton!) {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$^-/=)(!?&"
        var len = inputLenght.text.toInt()
        if (len == nil) {
            len = 8
            inputLenght.text = "8"
        }
        
        var randomString : NSMutableString = NSMutableString(capacity: len!)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        inputPassword.text = randomString
        
    }
    
    func copyPassword(sender: UIButton!) {

        UIPasteboard.generalPasteboard().string = inputPassword.text
        
        let passwordCopied = JSSAlertView().success(viewController!,
            title: NSLocalizedString("PasswordCopiedTitle", comment: ""),
            text: NSLocalizedString("PasswordCopiedMessage", comment: ""),
            buttonText: NSLocalizedString("Save", comment: ""),
            cancelButtonText: NSLocalizedString("Close", comment: ""))
        
        passwordCopied.addAction({ () -> Void in
            
            var pushToSave = AddCredentialViewController(nibName: "AddCredentialViewController", bundle: nil)
            self.viewController?.navigationController?.pushViewController(pushToSave, animated: true)
        })

    }
    
    

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}