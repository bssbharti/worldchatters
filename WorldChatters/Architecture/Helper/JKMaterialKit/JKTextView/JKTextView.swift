//
//  JKTextView.swift
//  MOM
//
//  Created by RAWAT on 17/10/17.
//  Copyright © 2017 360itpro. All rights reserved.
//

import UIKit


@IBDesignable
open class JKTextView: UITextView {
    
    
    private let placeholderLabel: UILabel = UILabel()
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    var didChangeText :((_ text:String)->Void)?
    @IBInspectable open var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
             self.setNeedsLayout()
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor = JKColor.placeHolderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
             self.setNeedsLayout()
        }
    }
    
    
    // Maximum length of text. 0 means no limit.
    @IBInspectable open var maxLength: Int = 0{
        didSet{
            self.textContainer.maximumNumberOfLines = maxLength
             self.setNeedsLayout()
        }
    }
    
    
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            self.setNeedsLayout()
        }
    }
    
    
    @IBInspectable public var borderColor: UIColor =  UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
             self.setNeedsLayout()
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
             self.setNeedsLayout()
            
        }
    }
    @IBInspectable public var masksToBounds : Bool = false
        {
        didSet
        {
            layer.masksToBounds = masksToBounds
             self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var clipsToBound : Bool = false
        {
        didSet
        {
            self.clipsToBounds = clipsToBound
             self.setNeedsLayout()
        }
    }
    
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
             self.setNeedsLayout()
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
             self.setNeedsLayout()
        }
    }
    
    override open var text: String! {
        didSet {
            textDidChange()
             self.setNeedsLayout()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
             self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var bottomBorderEnabled: Bool = true {
        didSet {
            bottomBorderLayer?.removeFromSuperlayer()
            bottomBorderLayer = nil
            if bottomBorderEnabled {
                bottomBorderLayer = CALayer()
                bottomBorderLayer?.frame = CGRect(x: 0, y: layer.bounds.height - 1, width: bounds.width, height: 1)
                bottomBorderLayer?.backgroundColor = bottomBorderColor.cgColor
                layer.addSublayer(bottomBorderLayer!)
            }
             self.setNeedsLayout()
        }
    }
    @IBInspectable public var bottomBorderWidth: CGFloat = 1.0
    @IBInspectable public var bottomBorderColor: UIColor = JKColor.Grey
    @IBInspectable public var bottomBorderHighlightWidth: CGFloat = 1.75
    fileprivate(set) var bottomBorderLayer: CALayer?
    
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
             self.setNeedsLayout()
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    
    // Limit the length of text
    @objc private func textDidChange() {
        
        placeholderLabel.isHidden = !text.isEmpty
        
        if maxLength > 0 && text.count > maxLength {
            
            let endIndex = text.index(text.startIndex, offsetBy: maxLength)
            //text = text.substring(to: endIndex)
            text =  String(text[..<endIndex])
            undoManager?.removeAllActions()
            if let block = didChangeText{
                block(text)
            }
            
        }
        
        setNeedsDisplay()
        
        
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
        
        bottomBorderLayer?.backgroundColor = isFirstResponder ? tintColor.cgColor : bottomBorderColor.cgColor
        let borderWidth = isFirstResponder ? bottomBorderHighlightWidth : bottomBorderWidth
        bottomBorderLayer?.frame = CGRect(x: 0, y: layer.bounds.height - borderWidth, width: layer.bounds.width, height: borderWidth)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidChangeNotification,
                                                  object: nil)
    }
    
}
