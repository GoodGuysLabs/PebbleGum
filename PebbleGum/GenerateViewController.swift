//
//  GenerateViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 15/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class GenerateViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.title = String(format: NSLocalizedString("GenerateTitle", comment: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - loadView
    override func loadView() {
        let view = GenerateView(frame: UIScreen.mainScreen().bounds)
        
        view.viewController = self
        self.view = view
        println("> GenerateViewController")
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

