//
//  AddCredentialViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 13/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit
import Realm

class AddCredentialViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let functions = theFunctions()
    let connectedPebble: AnyObject = theFunctions().pebbleInfos()
    var inputTitle:FloatLabelTextField!
    var inputEmail:FloatLabelTextField!
    var inputPassword:FloatLabelTextField!
    var inputNotes:UITextView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = String(format: NSLocalizedString("NewCredential", comment: ""))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        let addCredentialCheckButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "AddCredentialCheck:")
        navigationItem.rightBarButtonItem = addCredentialCheckButton
        
        // Keychain icon font
        var keychainNewIcon:UILabel! = UILabel(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/7, self.view.frame.width - self.view.frame.width/7, self.view.frame.height/10))
        keychainNewIcon.font = UIFont.fontAwesomeOfSize(self.view.frame.height/10)
        keychainNewIcon.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.7)
        keychainNewIcon.text = String.fontAwesomeIconWithName("fa-key")
        self.view.addSubview(keychainNewIcon)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "TextDidBeginEditing:", name: UITextFieldTextDidBeginEditingNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "TextDidEndEditing:", name: UITextFieldTextDidEndEditingNotification, object: nil)

        // Credential Input Title
        inputTitle = FloatLabelTextField(frame: CGRectMake(self.view.frame.width - self.view.frame.width/1.5, self.view.frame.height/6, self.view.frame.width - self.view.frame.width/2.3, self.view.frame.height/14))
        inputTitle.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputTitle", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputTitle.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputTitle.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputTitle.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputTitle.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputTitle.leftViewMode = UITextFieldViewMode.Always
        inputTitle.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputTitle.keyboardAppearance = .Dark
        self.view.addSubview(inputTitle)

        // Credential Input Email/Username
        inputEmail = FloatLabelTextField(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/3, self.view.frame.width - self.view.frame.width/6, self.view.frame.height/14))
        inputEmail.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputLogin", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputEmail.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputEmail.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputEmail.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputEmail.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputEmail.leftViewMode = UITextFieldViewMode.Always
        inputEmail.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputEmail.autocapitalizationType = .None
        inputEmail.autocorrectionType = .No
        inputEmail.keyboardType = .EmailAddress
        inputEmail.keyboardAppearance = .Dark
        self.view.addSubview(inputEmail)

        // Credential Input Password
        inputPassword = FloatLabelTextField(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/2.2, self.view.frame.width - self.view.frame.width/6, self.view.frame.height/14))
        inputPassword.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputPassword", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputPassword.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputPassword.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputPassword.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputPassword.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputPassword.leftViewMode = UITextFieldViewMode.Always
        inputPassword.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputPassword.autocapitalizationType = .None
        inputPassword.autocorrectionType = .No
        inputPassword.keyboardAppearance = .Dark
        inputPassword.secureTextEntry = true
        inputPassword.tag = 3
        self.view.addSubview(inputPassword)

        // Credential Input Notes
        inputNotes = UITextView(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/1.65, self.view.frame.width - self.view.frame.width/6, self.view.frame.height/7))
        inputNotes.delegate = self
        inputNotes.text = NSLocalizedString("AddCredentialInputNotes", comment: "")
        inputNotes.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputNotes.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputNotes.keyboardAppearance = .Dark
        inputNotes.tag = 4
        self.view.addSubview(inputNotes)

        println(Credential.allObjects())

    }
    
    // MARK: - loadView
    override func loadView() {
        let view = AddCredentialView(frame: UIScreen.mainScreen().bounds)
        
        view.viewController = self
        self.view = view
        println("> AddCredentialViewController")
    }
    
    func AddCredentialCheck(sender: AnyObject) {

        let realm = RLMRealm.defaultRealm()
        let getCredentials = Credential.allObjects()
        let newCredential = Credential()
        
        if ( getCredentials.count != 0 ) {
            let crementalId: AnyObject = getCredentials.lastObject() as Credential
            newCredential.credentialId = crementalId.credentialId + 1
        } else {
            newCredential.credentialId = 0
        }

        newCredential.credentialTitle = inputTitle.text
        newCredential.credentialEmail = inputEmail.text
        newCredential.credentialPassword = inputPassword.text
        newCredential.credentialNotes = inputNotes.text
        
        realm.beginWriteTransaction()
        realm.addOrUpdateObject(newCredential)
        realm.commitWriteTransaction()
        
        let confirmEntry = JSSAlertView().success(self, title: NSLocalizedString("CredentialAdded", comment: "Alert UI title when creating a new credential entry after tapping the button Done"))

        confirmEntry.addAction({ () -> Void in
            var afterEntryRedirect = TrousseauViewController(nibName: "TrousseauViewController", bundle: nil)
            self.navigationController?.popViewControllerAnimated(true)
        })
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
    
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.text == NSLocalizedString("AddCredentialInputNotes", comment: "") ) {
            textView.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}

