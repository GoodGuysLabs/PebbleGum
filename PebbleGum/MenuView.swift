//
//  SecondView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 04/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class MenuView: UIView, PBPebbleCentralDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var viewController: MenuViewController? = nil
    let imageView:UIImageView?
    let functions = theFunctions()
    var tableView: UITableView = UITableView()
    var items: [String] = [
                            NSLocalizedString("Keychain", comment: ""),
                            NSLocalizedString("Vault", comment: ""),
                            NSLocalizedString("Generate", comment: "")
                           ]

    override init(frame: CGRect)
    {
        super.init(frame: frame)

        // MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view

        // MARK: UIImage: Not Connected Pebble
        var pebbleNotConnectedImage = UIImage(named: "LightLogoWithoutBG&Text.png")
        var pebbleNotConnectedImageView = UIImageView(image: pebbleNotConnectedImage)
        let sizeOfThisImage = pebbleNotConnectedImage!.size
        let scaleFactor = frame.width / sizeOfThisImage.width
        let newHeight = sizeOfThisImage.height * scaleFactor
        pebbleNotConnectedImageView.frame = CGRect(x: (frame.width - frame.width/3)/2, y: 120.0, width: frame.width/3, height: newHeight/3)
        self.addSubview(pebbleNotConnectedImageView) // Adding the Pebble not connected image to the view

        tableView.frame = CGRectMake(0, 300.0, frame.width, frame.height-300.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0)
        tableView.separatorColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.2)
        tableView.scrollEnabled = false
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.addSubview(tableView)
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
        println("You selected cell #\(indexPath.row) !")
        
       // var anotherVC: UIViewController
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        
        //var afterConnectViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        //self.navigationController?.pushViewController(afterConnectViewController, animated: true)
        
        switch (indexPath.row) {
            case 0:
                let anotherVC = TrousseauViewController(nibName: "TrousseauViewController", bundle: nil)
                let backBarButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BackMenu", comment: "Back button title"), style: .Bordered, target: nil, action: nil)
                self.viewController?.navigationItem.backBarButtonItem = backBarButton
                self.viewController?.navigationController?.pushViewController(anotherVC, animated: true)
                println(cell?.textLabel?.text)
            case 1:
                println(cell?.textLabel?.text)
//                popupViewController.modalPresentationStyle = .Popover
//                popupViewController.preferredContentSize = CGSizeMake(50, 100)
//            
//                let popoverViewController = popupViewController.popoverPresentationController
//                popoverViewController?.permittedArrowDirections = .Any
//                popoverViewController?.delegate = self
//                popoverViewController?.sourceView = self
//                popoverViewController?.sourceRect = CGRect(x: 50 , y: 50, width: 1, height: 1)
            case 2:
                let popupViewController = GenerateViewController(nibName: "GenerateViewController", bundle: nil)
                let backBarButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("BackMenu", comment: "Back button title"), style: .Bordered, target: nil, action: nil)
                self.viewController?.navigationItem.backBarButtonItem = backBarButton
                self.viewController?.navigationController?.pushViewController(popupViewController, animated: true)
                println(cell?.textLabel?.text)
            default:
                fatalError("It shouldn't reach this message.")
        }

        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.12)
        cell.textLabel?.textColor = functions.UIColorFromRGB("FFFFFF", alpha: 0.8)
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-UltraLight", size: frame.width/8)
        cell.textLabel?.highlightedTextColor = functions.UIColorFromRGB("000000", alpha: 1.0)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}