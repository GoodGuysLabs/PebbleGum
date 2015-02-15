//
//  CredentialView.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 14/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class CredentialDetailView: UIView {
    
    var viewController: CredentialDetailViewController? = nil
    let imageView:UIImageView?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // MARK: UIImageView: Background Image Configuration
        imageView = UIImageView(frame:CGRectMake(0, 0, frame.width, frame.height))
        imageView!.image = UIImage(named:"background.png")
        self.addSubview(imageView!) // Adding the background image to the view
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}