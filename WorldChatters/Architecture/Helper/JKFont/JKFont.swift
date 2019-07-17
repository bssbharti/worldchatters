//
//  JKFont.swift
//  StableGuard
//
//  Created by Jitendra Kumar on 27/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit

enum OpenSans :Int{
    
    case Regular  = 0
    case Italic
    case Light
    case LightItalic
    case Semibold
    case SemiboldItalic
    case Bold
    case BoldItalic
    case ExtraBold
    case ExtraBoldItalic
 
    var fontname:String{
        switch self {
        case .Italic:
            return "OpenSans-Italic"
        case .Light:
            return "OpenSans-Light"
        case .LightItalic:
            return "OpenSans-LightItalic"
        case .Semibold:
            return "OpenSans-Semibold"
        case .SemiboldItalic:
            return "OpenSans-SemiboldItalic"
        case .Bold:
            return "OpenSans-Bold"
        case .BoldItalic:
            return "OpenSans-BoldItalic"
        case .ExtraBold:
            return "OpenSans-ExtraBold"
        case .ExtraBoldItalic:
            return "OpenSans-ExtraBoldItalic"
        default:
            return "OpenSans"
        }
   
    }
    func font(size:CGFloat)->UIFont?{
        let name  = self.fontname
       return UIFont(name: name, size: size)
    }
    
}
