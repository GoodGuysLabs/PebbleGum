//
//  MenuViewController.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 04/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}

class MenuViewController: UIViewController {
    
    let functions = theFunctions()
    let connectedPebble: AnyObject = theFunctions().pebbleInfos()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        navigationItem.setHidesBackButton(true, animated: false)
 
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Getting the last 4 characters of the Pebble serial number
        var pebbleSNLast4 = String(connectedPebble.serialNumber)
        pebbleSNLast4 = pebbleSNLast4.substringWithRange(Range<String.Index>(start: advance(pebbleSNLast4.endIndex, -4), end: pebbleSNLast4.endIndex))

        // Passing it to the navbar title
        self.title = String(format: NSLocalizedString("MenuViewTitle", comment: ""), pebbleSNLast4)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - loadView
    override func loadView() {
        let view = MenuView(frame: UIScreen.mainScreen().bounds)
        
        view.viewController = self
        self.view = view
        println("MenuViewController")
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

