//
//  JKColor.swift
// JKMaterialKit
//
//  Created by Jitendra Kumar on 08/01/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
    convenience public init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    convenience public init(hexString colorString: String!, alpha:CGFloat = 1.0) {
        // Convert hex string to an integer
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: colorString)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        let hexint = Int(hexInt)
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    convenience public init (ColorRGB r:CGFloat ,Grean g: CGFloat ,Blue b: CGFloat,alpha:CGFloat = 1.0){
        self.init(red:r/255.0, green:g/255.0, blue:b/255.0, alpha:alpha)
    }
    
}
public struct JKColor {
    public static let lightRed = #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1)
    public static let Red  = #colorLiteral(red: 0.9254901961, green: 0.137254902, blue: 0.1607843137, alpha: 1)
    public static let DarkRed = #colorLiteral(red: 0.9294117647, green: 0.1215686275, blue: 0.1607843137, alpha: 1)
    public static let Pink = #colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1)
    public static let Purple = #colorLiteral(red: 0.6117647059, green: 0.1529411765, blue: 0.6901960784, alpha: 1)
    public static let DeepPurple = #colorLiteral(red: 0.02352941176, green: 0.4784313725, blue: 0.7176470588, alpha: 1)
    public static let Indigo = #colorLiteral(red: 0.2470588235, green: 0.3176470588, blue: 0.7098039216, alpha: 1)
    
    public static let Blue = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1)
    public static let LightBlue = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1)
    public static let CornflowerBlue = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
    public static let DarkBlue = #colorLiteral(red: 0.007843137255, green: 0.4745098039, blue: 0.7607843137, alpha: 1)
    public static let DeepBlue  = #colorLiteral(red: 0.1960784314, green: 0.5137254902, blue: 0.9058823529, alpha: 1)
    public static let Cyan = #colorLiteral(red: 0, green: 0.737254902, blue: 0.831372549, alpha: 1)
    public static let Teal = #colorLiteral(red: 0, green: 0.5882352941, blue: 0.5333333333, alpha: 1)
    public static let ExtraLightGreen = #colorLiteral(red: 0.5450980392, green: 0.7647058824, blue: 0.2901960784, alpha: 1)
    public static let LightGreen  = #colorLiteral(red: 0.1450980392, green: 0.8078431373, blue: 0.3725490196, alpha: 1)
    public static let DrakGreen = #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1)
    public static let Green = #colorLiteral(red: 0.1333333333, green: 0.8156862745, blue: 0.3725490196, alpha: 1)
    public static let Lime = #colorLiteral(red: 0.8039215686, green: 0.862745098, blue: 0.2235294118, alpha: 1)
    public static let LightYellow = #colorLiteral(red: 1, green: 0.9215686275, blue: 0.231372549, alpha: 1)
    public static let Yellow  = #colorLiteral(red: 0.968627451, green: 0.7098039216, blue: 0.1960784314, alpha: 1)
    public static let DarkYellow  = #colorLiteral(red: 0.9647058824, green: 0.7137254902, blue: 0.1960784314, alpha: 1)
    public static let Amber = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
    public static let Orange = #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1)
    public static let DeepOrange = #colorLiteral(red: 1, green: 0.3411764706, blue: 0.1333333333, alpha: 1)
    public static let Brown = #colorLiteral(red: 0.4745098039, green: 0.3333333333, blue: 0.2823529412, alpha: 1)
    public static let Grey = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1)
    public static let BlueGrey = #colorLiteral(red: 0.3764705882, green: 0.4901960784, blue: 0.5450980392, alpha: 1)
    public static let skyBlue = #colorLiteral(red: 0.5529411765, green: 0.8039215686, blue: 0.9921568627, alpha: 1)
    public static let extraLightGrey  = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9450980392, alpha: 1)
    public static let placeHolderColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.6352941176, alpha: 1)
    public static let navigationBarColor =  #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
    public static let Downy = #colorLiteral(red: 0.3647058824, green: 0.7921568627, blue: 0.768627451, alpha: 1)
    public static let barColor = #colorLiteral(red: 0.1647058824, green: 0.1607843137, blue: 0.1647058824, alpha: 1)
    //RGB Color
    
}

