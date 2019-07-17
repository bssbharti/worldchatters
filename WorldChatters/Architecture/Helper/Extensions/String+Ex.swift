//
//  String+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
extension String{
    
    var numberFormatter:NumberFormatter { return NumberFormatter()                               }
    var intValue:       Int?            { return numberFormatter.number(from: self)?.intValue    }
    var int8Value:      Int8?           { return numberFormatter.number(from: self)?.int8Value   }
    var int16Value:     Int16?          { return numberFormatter.number(from: self)?.int16Value  }
    var int32Value:     Int32?          { return numberFormatter.number(from: self)?.int32Value  }
    var int64Value:     Int64?          { return numberFormatter.number(from: self)?.int64Value  }
    var floatValue:     Float?          { return numberFormatter.number(from: self)?.floatValue  }
    var doubleValue:    Double?         { return numberFormatter.number(from: self)?.doubleValue }
    var boolValue:      Bool?           { return numberFormatter.number(from: self)?.boolValue   }
    var decimalValue:   Decimal?        { return numberFormatter.number(from: self)?.decimalValue}
    var binaryValue:    Data?           { return self.data(using: .utf8)                         }
    var length:         Int             { return self.count                                      }
    
    var pairs: [String] {
        var result: [String] = []
        let characters = Array(self)
        stride(from: 0, to: count, by: 2).forEach {
            result.append(String(characters[$0..<min($0+2, count)]))
        }
        return result
    }
    
    var isAlphanumericWithWhiteSpace: Bool {
        let regex = try! NSRegularExpression(pattern: "[^A-Z0-9a-z ]", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    
    var isAlphanumeric: Bool {
        
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9 ]", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
        
    }
    //MARK:- isValidPassword
    var isValidPassword: Bool
    {
        if (self.isEmpty)
        {
            return false
        }
        
        let passRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$#]).{8,}$"
        let passwordTest=NSPredicate(format: "SELF MATCHES %@", passRegEx);
        return passwordTest.evaluate(with: self)
        
        
    }
    var removeWhiteSpace:String{
        return self.components(separatedBy: .whitespaces).joined(separator: "")
    }
    
    var isEmail: Bool {
        
        let regex = try? NSRegularExpression(pattern: "^(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){255,})(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){65,}@)(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22))(?:\\.(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-+[a-z0-9]+)*\\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-+[a-z0-9]+)*)|(?:\\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\\]))$", options: .caseInsensitive)
        
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    var checkSpecial: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9 ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
            
        }else{
            return true
        }
    }
    var checkAddress: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9._@#/()-+*., ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
            
        }else{
            return true
        }
    }
    var checkNumbers:Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return true
            
        }else{
            return false
        }
    }
    var onlyNumbers : Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^0-9].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var checkPhoneNumber:Bool{
        get{
            let phone_regex = "^\\d{3}-\\d{3}-\\d{4}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_regex)
            return phoneTest.evaluate(with: self)
        }
    }
    
    var onlyNumbersExpressionPlus: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^0-9+].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var onlyAlphabet:  Bool{
        
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var isValidateUrl : Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    func insert(_ string:String,ind:Int) -> String {
        return  String(self.prefix(ind)) + string + String(self.suffix(self.count-ind))
    }
    
    
    var containsAlphabets: Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains( where: { return set.contains(UnicodeScalar($0)!)  } )
    }
    /// Returns a new string made from the `String` by replacing all characters not in the unreserved
    /// character set (As defined by RFC3986) with percent encoded characters.
    
    var stringByAddingPercentEncoding: String? {
        let allowedCharacters = NSCharacterSet.urlQueryAllowed
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        
    }
    
    func safelyLimitedTo(length n: Int)->String {
        let c = String(self)
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    func substring(to : Int) -> String? {
        if (to >= length) {
            return nil
        }
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[..<toIndex])
        
    }
    
    func substring(from : Int) -> String? {
        if (from >= length) {
            return nil
        }
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return  String(self[Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))])
        
    }
    
    func character(_ at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }
    
    
    //MARK: - subscript
    subscript(range: ClosedRange<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return  String(self[lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex)])
        
    }
    subscript(i: Int) -> String {
        guard i >= 0 && i < self.count else { return "" }
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript(r: Range<Int>) -> String? {
        get {
            let stringCount = self.count as Int
            if (stringCount < r.upperBound) || (stringCount < r.lowerBound) {
                return nil
            }
            
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
            return String(self[(startIndex ..< endIndex)])
        }
    }
    
    var originalUrl:String?{
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
  
    func isEqualTo(other:String)->Bool{
        return self.caseInsensitiveCompare(other) == .orderedSame ? true : false
    }
}

//MARK:- EXTENSION FOR NSAttributedString
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.width
    }
}
