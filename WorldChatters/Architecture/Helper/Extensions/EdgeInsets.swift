//
//  EdgeInsets.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//


import UIKit

extension UIEdgeInsets{
    @discardableResult
    public static func all(_ value:CGFloat)->UIEdgeInsets{
        return UIEdgeInsets(top: value, left: value, bottom:value, right: value)
    }
    @discardableResult
    public static func only(top: CGFloat = 0.0, left: CGFloat = 0.0, bottom: CGFloat = 0.0, right: CGFloat = 0.0)->UIEdgeInsets{
        return UIEdgeInsets(top: top, left: left, bottom:bottom, right: right)
    }
    @discardableResult
    public static func symmetric(vertical: CGFloat = 0.0, horizontal: CGFloat = 0.0)->UIEdgeInsets{
        return UIEdgeInsets(top: vertical, left: horizontal, bottom:vertical, right: horizontal)
    }
}
public enum EdgeInsets {
    case left(_ value:CGFloat)
    case right(_ value:CGFloat)
    case top(_ value:CGFloat)
    case bottom(_ value:CGFloat)
    case all(_ value:CGFloat)
    case symmetric(vertical: CGFloat, horizontal: CGFloat)
    case only(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    case none
    public var result:UIEdgeInsets{
        switch self {
        case .left(let value):return UIEdgeInsets.only(left: value)
        case .right (let value): return UIEdgeInsets.only(right: value)
        case .top (let value): return UIEdgeInsets.only(top: value)
        case .bottom (let value):  return UIEdgeInsets.only(bottom: value)
        case .symmetric(let vertical,let horizontal): return UIEdgeInsets.symmetric(vertical: vertical, horizontal: horizontal)
        case .all(let value): return UIEdgeInsets.all(value)
        case .only(let top,let left,let bottom, let right):return UIEdgeInsets.only(top: top, left: left, bottom: bottom, right: right)
        case .none: return UIEdgeInsets.zero
        }
    }
   
}

