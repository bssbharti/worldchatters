//  UIStackView.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//


import UIKit

extension UIStackView{
    
    @discardableResult
    open func margin(_ margins:EdgeInsets)->UIStackView{
        layoutMargins = margins.result
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    @discardableResult
    open func padding(_ padding:EdgeInsets)->UIStackView{
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = padding.result
        return self
    }
    
    open func leftPadding(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
    @discardableResult
    open func topPadding(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    open func bottomPadding(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }
    
    @discardableResult
    open func rightPadding(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
    convenience init(children:[UIView],axis:NSLayoutConstraint.Axis = .vertical,spacing:CGFloat = 0, alignment: UIStackView.Alignment = .fill) {
        self.init(arrangedSubviews: children)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        
    }
   open func distribution( _ distribution:UIStackView.Distribution)->UIStackView{
        self.distribution = distribution
        return self
    }
}

extension UIView{
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, children: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stackView = UIStackView(children: children, axis: axis, spacing: spacing, alignment: alignment)
        addSubview(stackView)
        stackView.fillSuperview()
        return stackView
    }
    
    @discardableResult
    open func vStack(_ children:  UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        return _stack(.vertical, children: children, spacing: spacing, alignment: alignment)
    }
    
    @discardableResult
    open func hStack(_ children: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        return _stack(.horizontal, children: children, spacing: spacing, alignment: alignment)
    }
    
    @discardableResult
    open func size<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self as! T
    }
    
    @discardableResult
    open func height(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func width(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func border(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
}

