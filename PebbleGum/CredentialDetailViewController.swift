//
//  CredentialViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 14/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit
import Realm

class CredentialDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    let connectedPebble: AnyObject = theFunctions().pebbleInfos()
    var credTitle:String!
    var credId:Int!
    let credentials = Credential.allObjects()
    let realm = RLMRealm.defaultRealm()
    var choosenCredential:RLMResults?
    
    var inputTitle:FloatLabelTextField!
    var categoryPicker:UIPickerView!
    var selectedIcon:String = ""
    var keychainNewIcon:UILabel!
    var inputEmail:FloatLabelTextField!
    var inputPassword:FloatLabelTextField!
    var inputNotes:UITextView!
    let theCategories = Category.allObjects().sortedResultsUsingProperty("categoryName", ascending: true)

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewWillAppear(animated: Bool) {
        let backBarButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BackKeychain", comment: "Back button title"), style: .Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        
        let addCredentialCheckButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "AddCredentialCheck:")
        navigationItem.rightBarButtonItem = addCredentialCheckButton
        
        var credDataResults:RLMResults
        credDataResults = Credential.objectsWhere("credentialId = %d", credId)
        var credDataObject = credDataResults.firstObject() as Credential
        
        // Keychain icon font
        keychainNewIcon = UILabel(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/7, self.view.frame.width - self.view.frame.width/7, self.view.frame.height/10))
        keychainNewIcon.font = UIFont.fontAwesomeOfSize(self.view.frame.height/10)
        keychainNewIcon.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.7)
        var theIcon:Category = credDataObject.category! as Category
        keychainNewIcon.text = String.fontAwesomeIconWithName(theIcon.categoryIcon)
        self.view.addSubview(keychainNewIcon)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "TextDidBeginEditing:", name: UITextFieldTextDidBeginEditingNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "TextDidEndEditing:", name: UITextFieldTextDidEndEditingNotification, object: nil)
        
        // Credential Input Title
        inputTitle = FloatLabelTextField(frame: CGRectMake(self.view.frame.width - self.view.frame.width/1.5, self.view.frame.height/6, self.view.frame.width - self.view.frame.width/2.3, self.view.frame.height/14))
        inputTitle.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputTitle", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputTitle.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputTitle.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputTitle.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputTitle.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputTitle.leftViewMode = UITextFieldViewMode.Always
        inputTitle.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputTitle.keyboardAppearance = .Dark
        inputTitle.text = credDataObject.credentialTitle
        self.view.addSubview(inputTitle)
        
        // Credential Category Picker View
        categoryPicker = UIPickerView(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/3.5, self.view.frame.width - self.view.frame.width/6, self.view.frame.height/12))
        categoryPicker.delegate = self
        categoryPicker.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        categoryPicker.showsSelectionIndicator = true
        categoryPicker.selectRow(9, inComponent: 0, animated: true)
        self.view.addSubview(categoryPicker)

        // Credential Input Email/Username
        inputEmail = FloatLabelTextField(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/1.8, self.view.frame.width - self.view.frame.width/6, self.view.frame.height/14))
        inputEmail.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputLogin", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputEmail.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputEmail.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputEmail.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputEmail.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputEmail.leftViewMode = UITextFieldViewMode.Always
        inputEmail.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputEmail.autocapitalizationType = .None
        inputEmail.autocorrectionType = .No
        inputEmail.keyboardType = .EmailAddress
        inputEmail.keyboardAppearance = .Dark
        inputEmail.text = credDataObject.credentialEmail
        self.view.addSubview(inputEmail)
        
        // Credential Input Password
        inputPassword = FloatLabelTextField(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/1.5, self.view.frame.width - self.view.frame.width/6, self.view.frame.height/14))
        inputPassword.attributedPlaceholder = NSAttributedString(string: String(format: NSLocalizedString("AddCredentialInputPassword", comment: "")), attributes:[NSForegroundColorAttributeName: theFunctions().UIColorFromRGB("D1CCC0", alpha: 0.8)])
        inputPassword.titleActiveTextColour = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        inputPassword.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputPassword.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputPassword.leftView = UIView(frame: CGRectMake(0, 0, 5, 20))
        inputPassword.leftViewMode = UITextFieldViewMode.Always
        inputPassword.clearButtonMode = UITextFieldViewMode.WhileEditing
        inputPassword.autocapitalizationType = .None
        inputPassword.autocorrectionType = .No
        inputPassword.keyboardAppearance = .Dark
        inputPassword.secureTextEntry = true
        inputPassword.tag = 3
        inputPassword.text = credDataObject.credentialPassword
        self.view.addSubview(inputPassword)
        
        // Credential Input Notes
        inputNotes = UITextView(frame: CGRectMake(self.view.frame.width/14, self.view.frame.height/1.3, self.view.frame.width - self.view.frame.width/6, self.view.frame.height/7))
        inputNotes.delegate = self
        inputNotes.text = NSLocalizedString("AddCredentialInputNotes", comment: "")
        inputNotes.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputNotes.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        inputNotes.keyboardAppearance = .Dark
        inputNotes.tag = 4
        inputPassword.text = credDataObject.credentialNotes
        self.view.addSubview(inputNotes)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - loadView
    override func loadView() {
        let view = CredentialDetailView(frame: UIScreen.mainScreen().bounds)

        self.title = credTitle
        choosenCredential = Credential.objectsWhere("credentialId = %d", credId)

        view.viewController = self
        self.view = view
        println("> CredentialViewController")
    }
    
    func AddCredentialCheck(sender: AnyObject) {

        
        println("En dev")
        
//        let realm = RLMRealm.defaultRealm()
//        let getCredentials = Credential.allObjects()
//        let newCredential = Credential()
//        var theCategory:RLMResults
//        
//        if (selectedIcon != "") {
//            theCategory = Category.objectsWhere("categoryName = %@", selectedIcon)
//        } else {
//            theCategory = Category.objectsWhere("categoryName = 'Apple'")
//        }
//        let categoryObject:Category = theCategory.firstObject() as Category
//        
//        if ( getCredentials.count != 0 ) {
//            let crementalId: AnyObject = getCredentials.lastObject() as Credential
//            newCredential.credentialId = crementalId.credentialId + 1
//        } else {
//            newCredential.credentialId = 0
//        }
//        
//        // Find the object to update
//        var updateCredential = Credential.objectsWhere("credentialId = %d", credId)
//        // Casting it to write it
//        var updateObject = updateCredential as Credential
//        
//        updateCredential.credentialTitle = inputTitle.text as Credential
//        updateCredential.credentialEmail = inputEmail.text
//        updateCredential.credentialPassword = inputPassword.text
//        updateCredential.credentialNotes = inputNotes.text
//        updateCredential.category = categoryObject
//        
//        realm.beginWriteTransaction()
//        realm.addOrUpdateObject(newCredential)
//        realm.commitWriteTransaction()
//        
//        let confirmEntry = JSSAlertView().success(self,
//            title: String(format: NSLocalizedString("CredentialAddedTitle", comment: "Alert UI title when creating a new credential entry after tapping the button Done")),
//            text: String(format: NSLocalizedString("CredentialAddedMessage", comment: "Alert UI message when creating a new credential entry after tapping the button Done"), inputTitle.text)
//        )
//        
//        confirmEntry.addAction({ () -> Void in
//            var afterEntryRedirect = TrousseauViewController(nibName: "TrousseauViewController", bundle: nil)
//            self.navigationController?.popViewControllerAnimated(true)
//        })
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
        
        theTextField.backgroundColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.12)
        theTextField.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(theCategories.count)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let cat: Category = theCategories.objectAtIndex(UInt(row)) as Category
        var catIcon = cat.categoryIcon
        
        keychainNewIcon.text = String.fontAwesomeIconWithName(catIcon)
        selectedIcon = cat.categoryName
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        let cat: Category = theCategories.objectAtIndex(UInt(row)) as Category
        var catName = cat.categoryName
        
        return catName
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let cat: Category = theCategories.objectAtIndex(UInt(row)) as Category
        let attributedString = NSAttributedString(string: cat.categoryName, attributes: [NSForegroundColorAttributeName:theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)])
        
        return attributedString
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
