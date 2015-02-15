//
//  KeychainCustomCell.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 15/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit

class KeychainCustomCell: UITableViewCell {

    var titleLabel:UILabel = UILabel()
    var iconLabel:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let frameWidth = CGRectGetWidth(frame)
        
        println("the width = \(frameWidth)")
        
        // Title Label Configuration
        self.titleLabel = UILabel(frame: CGRectMake(80, 0, frameWidth, 80))
        self.titleLabel.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.8)
        self.titleLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: frame.width/14)
        self.titleLabel.highlightedTextColor = theFunctions().UIColorFromRGB("000000", alpha: 1.0)
        
        // Icon Label Configuration
        self.iconLabel = UILabel(frame: CGRectMake(20, 0, frameWidth, 80))
        self.iconLabel.font = UIFont.fontAwesomeOfSize(40)
        self.iconLabel.textColor = theFunctions().UIColorFromRGB("FFFFFF", alpha: 0.5)
        
        // Adding the labels to the subview
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.iconLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override convenience init() {
//        self.ini
//        
//        self.theLabel = UILabel(frame: CGRectMake(80, 0, 250, 80))
//        
//        self.contentView.addSubview(self.theLabel)
//    }

    
}