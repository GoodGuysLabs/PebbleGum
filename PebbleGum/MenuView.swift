//
//  SecondView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 04/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit
import Realm

// Declaring Passwords class Object
class Passwords: RLMObject {
    dynamic var password = ""
    dynamic var category = RLMArray(objectClassName: Categories.className())
}

// Declaring Categories class Object
class Categories: RLMObject {
    dynamic var categoryName = ""
}

class MenuView: UIView, PBPebbleCentralDelegate {
    
    var viewController: MenuViewController? = nil
    let imageView:UIImageView?
    let functions = theFunctions()
    var inputIt: UITextField? = nil
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // Creating a new realm object
        let realm = RLMRealm.defaultRealm()
        // Starting to write in the DB
        realm.beginWriteTransaction()
        
        // Creating a new Categories object
        let testCategory = Categories()
        testCategory.categoryName = "Test Catégorie"
        
        // Creating a new Passwords object
        let testPassword = Passwords()
        testPassword.password = "topsecret"
        // Insert the previously created category the the password
        testPassword.category.addObject(testCategory)
        
        // Persist the object to the DB
        realm.addObject(testPassword)
        // And write it
        realm.commitWriteTransaction()

        // Fetching all the passwords
        let pass = Passwords.allObjects()

        println(pass)
        

        // MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view
        
        inputIt = UITextField(frame: CGRectMake(frame.width/14, frame.height/2, frame.width - frame.width/7, frame.height/12))
        inputIt!.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        inputIt!.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        self.addSubview(inputIt!)

        // MARK: UIButton: Tap To Connected Pebble Label Configuration
        // Global state
        var saveValueButton = UIButton(frame: CGRectMake(frame.width/14, frame.height - frame.height/5, frame.width/3, frame.height/12))
        saveValueButton.setTitle(NSLocalizedString("SaveMe", comment: "SaveMe"), forState: UIControlState.Normal)
        saveValueButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: frame.width/16)
        saveValueButton.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        // Normal state
        saveValueButton.setTitleColor(functions.UIColorFromRGB("d9d9d9", alpha: 1.0), forState: UIControlState.Normal)
        // Highlighted state
        saveValueButton.setTitleColor(functions.UIColorFromRGB("ffffff", alpha: 1.0), forState: UIControlState.Highlighted)
        saveValueButton.addTarget(self, action: "saveMeAction:", forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(saveValueButton)
        
        // MARK: UIButton: Tap To Connected Pebble Label Configuration
        // Global state
        var loadValueButton = UIButton(frame: CGRectMake(frame.width - frame.width/2, frame.height - frame.height/5, frame.width/3, frame.height/12))
        loadValueButton.setTitle(NSLocalizedString("LoadMe", comment: "LoadMe"), forState: UIControlState.Normal)
        loadValueButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: frame.width/16)
        loadValueButton.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        // Normal state
        loadValueButton.setTitleColor(functions.UIColorFromRGB("d9d9d9", alpha: 1.0), forState: UIControlState.Normal)
        // Highlighted state
        loadValueButton.setTitleColor(functions.UIColorFromRGB("ffffff", alpha: 1.0), forState: UIControlState.Highlighted)
        loadValueButton.addTarget(self, action: "loadMeAction:", forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(loadValueButton)
        
    }
    
    func saveMeAction(send: UIButton!) {

        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(self.inputIt!.text, forKey: "myUberSetting")
        
        defaults.synchronize()
        JSSAlertView().success(viewController!, title: "Text Saved", text: String(format: "Congrats nig, your text is now saved: \"%@\"", self.inputIt!.text), buttonText: "Alright, get out of here")
    }
    
    func loadMeAction(send: UIButton!) {
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let myUberSettingIsNotNil = defaults.objectForKey("myUberSetting") as? String {
            println("Is: ")
            var mySetting = defaults.objectForKey("myUberSetting") as String
            println(mySetting)
            JSSAlertView().success(viewController!, title: "HUEHUEHUE", text: String(format: "Saved text: %@", mySetting), buttonText: "wow much knowledge")
        } else {
            JSSAlertView().warning(viewController!, title: "No text found", text: "Sheit, where's the text nig ?", buttonText: "The chicken ate it")
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.endEditing(true)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}