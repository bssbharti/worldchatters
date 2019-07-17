//
//  UISearchBar+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
//MARK: - UISearchBar Extension

extension UISearchBar{
 
   @IBInspectable var searchBarTextColor:UIColor?{
        set{
            searchTextField()?.textColor = (newValue == nil) ? .black : newValue
        }
        get{
            return self.searchTextField()?.textColor
        }
    }
   
    fileprivate func searchTextField()->UITextField?{
        return self.value(forKey: "searchField") as? UITextField
    }

    func set(placeholderColor color:UIColor = JKColor.Grey,textColor:UIColor = UIColor.darkGray,canceltitleColor:UIColor = JKColor.Blue) ->UITextField? {
        if self.placeholder != nil {
            if  let searchTextField = self.searchTextField(), searchTextField.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
                searchTextField.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: color])
                searchTextField.clearButtonMode = .never
                
                
            }
            
        }
        
        for subView in self.subviews
        {
            if subView.isKind(of:UIButton.self)
            {
                let searchbtn : UIButton = subView as! UIButton
                searchbtn .setTitleColor(canceltitleColor, for:.normal)
            }
        }
        return self.searchTextField()
      
    }
    
}


