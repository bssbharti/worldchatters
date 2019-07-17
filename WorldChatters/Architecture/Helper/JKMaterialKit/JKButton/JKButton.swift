//
//  JKButton.swift
// JKMaterialKit
//
//  Created by Jitendra Kumar on 27/12/16.
//  Copyright © 2016 Jitendra. All rights reserved
//

import UIKit

@IBDesignable
open class JKButton : UIButton
{
    @IBInspectable public var isAutoSize: Bool = false {
        didSet {
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var imageColor: UIColor = .clear {
        didSet {
            
            if imageColor != .clear {
                
                if  let image = self.image(for: UIControl.State()) {
                    let tmImage  = image.withRenderingMode(.alwaysTemplate)
                    self.setImage(tmImage, for: UIControl.State())
                    self.tintColor = imageColor
                    
                }else if let image = self.backgroundImage(for: UIControl.State()) {
                    let tmImage  = image.withRenderingMode(.alwaysTemplate)
                    self.setBackgroundImage(tmImage, for: UIControl.State())
                    self.tintColor = imageColor
                    }
            }
           
        }
    }
    
   
    @IBInspectable public var isShadow: Bool = false
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            
        }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 3) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var shadowRadius : CGFloat = 3
        {
        didSet
        {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable public var borderColor: UIColor =  UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
           
        }
    }
    @IBInspectable public var masksToBounds : Bool = false
        {
            didSet
            {
              layer.masksToBounds = masksToBounds
        }
    }
   
    @IBInspectable public var clipsToBound : Bool = false
        {
        didSet
        {
            self.clipsToBounds = clipsToBound
        }
    }
  


    // MARK - initilization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
 
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    // MARK - setup methods
    private func setupLayer() {
        adjustsImageWhenHighlighted = false
        
    }

   
    override open func layoutSubviews() {
        super.layoutSubviews()
        if isShadow == true
        {
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            layer.masksToBounds = masksToBounds
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowPath = shadowPath.cgPath
        }
        
    }
    var shouldUpdateSize: Bool = false
    var updateImageSize:CGSize{
        return self.intrinsicContentSize
    }
    override open func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        super.setBackgroundImage(image, for: state)
        if isAutoSize, let image = image, image.size != imageSize {
            imageSize = image.size
            self.invalidateIntrinsicContentSize()
            shouldUpdateSize = true
        }
    }
    override open func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        if  isAutoSize, let image = image, image.size != imageSize {
            imageSize = image.size
            self.invalidateIntrinsicContentSize()
            shouldUpdateSize = true
        }
    }
    private var imageSize: CGSize = CGSize(width: 1920, height: 1080)
    
    open override var intrinsicContentSize: CGSize {
        if isAutoSize {
            let aspect = imageSize.width/imageSize.height
            return CGSize(width: self.frame.width, height: self.frame.width/aspect)
        }else{
            
              return super.intrinsicContentSize
        }
    }
}
extension UIButton {
    // MARK: - UIButton+Aligment
    
    func alignContentVerticallyByCenter(offset:CGFloat = 10) {
        let buttonSize = frame.size
        
        if let titleLabel = titleLabel,
            let imageView = imageView {
            
            if let buttonTitle = titleLabel.text,
                let image = imageView.image , let font = titleLabel.font{
                let titleString:NSString = NSString(string: buttonTitle)
                let  attributes:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font :font]
                let titleSize = titleString.size(withAttributes: attributes)
                let buttonImageSize = image.size
                let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + offset)) / 2
                let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2
                imageEdgeInsets = UIEdgeInsets.init(top: topImageOffset,
                                                   left: leftImageOffset,
                                                   bottom: 0,right: 0)
                
                let titleTopOffset = topImageOffset + offset + buttonImageSize.height
                let leftTitleOffset = (buttonSize.width - titleSize.width) / 2 - image.size.width
                
                titleEdgeInsets = UIEdgeInsets.init(top: titleTopOffset,
                                                   left: leftTitleOffset,
                                                   bottom: 0,right: 0)
            }
        }
    }
}
