//
//  UILabel+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

//MARK: - UILabel Extension
extension UILabel {
    convenience public init(text:String?,font:UIFont? = UIFont.systemFont(ofSize: 14),textColor:UIColor = .black,textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1){
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    func heightToFit(_ string:String,width:CGFloat) -> CGFloat{
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.byWordWrapping
        let rect = string.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.height
        
    }
    
    func resizeHeightToFit() {
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.byWordWrapping
        let rect = text!.boundingRect(with: CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        self.frame.size.height = rect.height
    }
}

