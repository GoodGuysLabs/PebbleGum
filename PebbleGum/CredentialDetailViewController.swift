//
//  CredentialViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 14/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit
import Realm

class CredentialDetailViewController: UIViewController {

    let connectedPebble: AnyObject = theFunctions().pebbleInfos()
    var credTitle:String!
    var credId:Int!
    let credentials = Credential.allObjects()
    let realm = RLMRealm.defaultRealm()
    var choosenCredential:RLMResults?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewWillAppear(animated: Bool) {
        let backBarButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BackKeychain", comment: "Back button title"), style: .Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
