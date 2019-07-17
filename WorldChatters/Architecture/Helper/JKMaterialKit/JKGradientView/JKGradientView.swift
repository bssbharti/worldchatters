//
//  JKGradientView.swift
//  CAD
//
//  Created by Jitendra Kumar on 25/01/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

@IBDesignable class JKGradientView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
     /// The color of the drop-shadow, defaults to black.
    @IBInspectable public var shadowColor: UIColor = .clear {
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
    @IBInspectable public var shadowRadius : CGFloat = 3.0{
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
    @IBInspectable public var borderColor: UIColor =  .clear {
        didSet {
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var masksToBounds : Bool = false{
        didSet{
            
            self.setNeedsDisplay()
        }
        
    }
    @IBInspectable public var clipsToBound : Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var startPoint : CGPoint = CGPoint(x: 0, y: 0.5){
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var endPoint : CGPoint = CGPoint(x: 1, y: 0.5){
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var topColor: UIColor = .red {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = .yellow {
        didSet {
            setNeedsLayout()
        }
    }
    
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        self.gradientLayer = self.layer as? CAGradientLayer
        self.gradientLayer.colors = [topColor, bottomColor].map({$0.cgColor})
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBound
         layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        if isShadow {
            layer.masksToBounds = false
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowRadius = shadowRadius
            self.layer.shadowOpacity = shadowOpacity
            
        }else{
            layer.masksToBounds = masksToBounds
        }
        
    }
    
    func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
        let fromColors = self.gradientLayer?.colors
      
        self.gradientLayer?.colors = [newTopColor,newBottomColor].map({$0.cgColor})
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = fromColors
        animation.toValue = [newTopColor,newBottomColor].map({$0.cgColor})
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.gradientLayer?.add(animation, forKey:"animateGradient")
    }
    
   
}
