//
//  TrousseauViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 13/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class TrousseauViewController: UIViewController {
    
    let functions = theFunctions()
    let connectedPebble: AnyObject = theFunctions().pebbleInfos()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewWillAppear(animated: Bool) {
        let backBarButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BackKeychain", comment: "Back button title"), style: .Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        let addCredential = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "redirectToAddCredential:")
        navigationItem.rightBarButtonItem = addCredential
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - loadView
    override func loadView() {
        let view = TrousseauView(frame: UIScreen.mainScreen().bounds)
        
        view.viewController = self
        self.view = view
        println("> TrousseauViewController")
    }

    func redirectToAddCredential(sender: UIBarButtonItem!) {
        var AddCredentialVCRedirect = AddCredentialViewController(nibName: "AddCredentialViewController", bundle: nil)
        
        // Edit animation
//        UIView.animateWithDuration(0.5, animations: {
//            self.navigationController?.pushViewController(AddCredentialVCRedirect, animated: false)
//            UIView.setAnimationTransition(UIViewAnimationTransition.None, forView: self.navigationController!.view, cache: false)
//        })

        self.navigationController?.pushViewController(AddCredentialVCRedirect, animated: true)
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


//class CustomCell: UITableViewCell {
//    
//    var theLabel:UILabel?
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.theLabel?.frame = CGRectMake(80, 0, 250, 80)
//        
//    }
////    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
////        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
////    }
////
////    required init(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//    
////    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
////        
////        theLabel?.frame = CGRectMake(80, 0, 250, 80)
////        
////        return cell
////    }
//    
//    
//}
