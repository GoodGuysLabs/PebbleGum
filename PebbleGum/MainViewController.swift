//
//  ViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 01/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PBPebbleCentralDelegate {
    
    let functions = theFunctions()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewWillAppear(animated: Bool) {
        self.title = NSLocalizedString("MainViewTitle", comment: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var checkIt = functions.checkPebbleIsConnected()
        
        if (checkIt[2] == "2") {
            println("Yep !")
            var afterConnectViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
            self.navigationController?.pushViewController(afterConnectViewController, animated: true)
        } else {
            println("Nope !")
        }   
    }
    
    // MARK: - loadView
    override func loadView() {
        let view = MainView(frame: UIScreen.mainScreen().bounds)
        
        view.viewController = self
        self.view = view
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

