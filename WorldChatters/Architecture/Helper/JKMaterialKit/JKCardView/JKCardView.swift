//
//  JKCardView.swift
//
//  Created by Jitendra Kumar on 08/01/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

public enum RectCornerRadiusType:Int {
    case all
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case incoming
    case outgoing
    case none
    var rectCorner:UIRectCorner?{
        switch self {
        case .top:
            return [.topLeft,.topRight]
        case .bottom:
            return [.bottomLeft,.bottomRight]
        case .left:
            return [.topLeft,.bottomLeft]
        case .right:
            return [.topRight,.bottomRight]
        case .topLeft:
            return [.topLeft]
        case .topRight:
            return [.topRight]
        case .bottomLeft:
            return [.bottomLeft]
        case .bottomRight:
            return [.bottomRight]
        case .incoming:
            return [.topLeft,.bottomLeft,.bottomRight]
        case .outgoing:
            return [.topRight,.bottomLeft,.bottomRight]
        case .all:
            return [.allCorners]
        default:
            return nil
            
        }
    }
}
@IBDesignable
public class JKCardView: UIView {
 
     public var rectCornerType: RectCornerRadiusType = .none{
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var cornerRadii: CGFloat = 3.0{
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    /// The color of the drop-shadow, defaults to black.
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            
            
            self.setNeedsDisplay()
        }
    }
    /// Whether to display the shadow, defaults to false.
    @IBInspectable public var isShadow: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    /// The opacity of the drop-shadow, defaults to 0.5.
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    /// The x,y offset of the drop-shadow from being cast straight down.
    @IBInspectable public var shadowOffset: CGSize = CGSize(width:0,height:3) {
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    /// The blur radius of the drop-shadow, defaults to 3.
    @IBInspectable public var shadowRadius : CGFloat = 3.0
        {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderColor: UIColor =  UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var masksToBounds : Bool = false
        {
        didSet
        {
            layer.masksToBounds = isShadow ? false : masksToBounds
            self.setNeedsDisplay()
        }
        
    }
    @IBInspectable public var clipsToBound : Bool = false
        {
        didSet
        {
            self.clipsToBounds = clipsToBound
            self.setNeedsDisplay()
        }
    }
    
    
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if isShadow == true
        {
            
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
           
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
            layer.shadowPath = shadowPath.cgPath
        }
        else{
            // Disable the shadow.
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
        }
        if self.rectCornerType != .none{
            layer.cornerRadius = 0.0
            self.rectCornerRadius(rectCornerRadiusType: self.rectCornerType, cornerRadius: cornerRadii)
        }else{
            layer.cornerRadius = cornerRadius
        }
        self.setNeedsDisplay()
        
    }
    
}




extension CALayer {
    func rectCornerRadius(rectCornerRadiusType type: RectCornerRadiusType = .none, cornerRadius radius: CGFloat = 3.0) {
        if type == .none {
            return
        }
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: type.rectCorner!,
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        mask = shape
    }
}
/// Clear the child views.
public  extension UIView {
    
    func clearChildViews(){
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func rectCornerRadius(rectCornerRadiusType type: RectCornerRadiusType = .none, cornerRadius radius: CGFloat = 3.0) {
        self.layer.rectCornerRadius(rectCornerRadiusType: type, cornerRadius: radius)
        self.setNeedsDisplay()
    }
}


