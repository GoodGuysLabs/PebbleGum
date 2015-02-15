//
//  TrousseauView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 13/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit
import Realm

class TrousseauView: UIView, PBPebbleCentralDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var viewController: TrousseauViewController? = nil
    let imageView:UIImageView?
    let functions = theFunctions()
    var keychainLabel:UILabel!
    var tableView: UITableView = UITableView()
    let credentials = Credential.allObjects()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view
        
        // MARK: Label: PebbleGum Logo Configuration
        keychainLabel = UILabel(frame: CGRectMake(frame.width/14, frame.height/7, frame.width - frame.width/7, frame.height/10 ))
        keychainLabel.text = NSLocalizedString("Keychain", comment: "")
        keychainLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: frame.width/6)
        keychainLabel.textAlignment = NSTextAlignment.Center
        keychainLabel.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 1.0)
        self.addSubview(keychainLabel) // Adding the Pebble Gum logo to the view
        
        tableView.frame = CGRectMake(0, keychainLabel.frame.origin.y + frame.height/10 + 40.0, frame.width, frame.height - keychainLabel.frame.origin.y - frame.height/10 - 40.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.2)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.addSubview(tableView)

    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfResult = self.credentials.count
        
        return Int(numberOfResult)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.tableView.registerClass(KeychainCustomCell.self, forCellReuseIdentifier: "cell")

        let cell:KeychainCustomCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as KeychainCustomCell

        let cred: Credential = credentials.objectAtIndex(UInt(indexPath.row)) as Credential
        var credIcon = cred.category?.categoryIcon
        cell.titleLabel.text = cred.credentialTitle
        cell.iconLabel.text = String.fontAwesomeIconWithName(credIcon!)

//        cell.textLabel?.text = cred.credentialTitle
//        cell.detailTextLabel?.text = cred.category?.categoryName

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
        println("You selected cell #\(indexPath.row) !")
        
        let cred: Credential = credentials.objectAtIndex(UInt(indexPath.row)) as Credential

        var pushToCred = CredentialDetailViewController(nibName: "CredentialDetailViewController", bundle: nil)
        pushToCred.credTitle = cred.credentialTitle
        pushToCred.credId = cred.credentialId
        self.viewController?.navigationController?.pushViewController(pushToCred, animated: true)
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let cred: Credential = self.credentials.objectAtIndex(UInt(indexPath.row)) as Credential
            
            let confirm = JSSAlertView().info(viewController!,
                                title: NSLocalizedString("AlertDeleteCredentialTitle", comment: ""),
                                text: String(format: NSLocalizedString("AlertDeleteCredentialMessage", comment: ""), cred.credentialTitle),
                                buttonText: "Yes",
                                cancelButtonText: "Nope")

            confirm.addAction({ () -> Void in
                let realm = RLMRealm.defaultRealm()
                var credentialToDelete = Credential.objectsWhere("credentialId = %d", cred.credentialId)
                realm.beginWriteTransaction()
                realm.deleteObject(credentialToDelete.firstObject() as RLMObject)
                realm.commitWriteTransaction()
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            })
        }
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        cell.textLabel?.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-UltraLight", size: frame.width/14)
        cell.textLabel?.highlightedTextColor = functions.UIColorFromRGB("000000", alpha: 1.0)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}