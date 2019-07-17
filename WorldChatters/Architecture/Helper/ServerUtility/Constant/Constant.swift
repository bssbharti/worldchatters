//
//  Constant.swift
//  StableGuard
//
//  Created by Jitendra Kumar on 24/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.

import Foundation
import UIKit


func async(onCompletion:@escaping()->Void){
    DispatchQueue.main.async {
        onCompletion()
    }
    
}
func asyncExecute(onCompletion:@escaping()->Void){
    DispatchQueue.main.async(execute: {
        onCompletion()
    })
}

var rootController:UIViewController?{
    return AppDelegate.shared.window?.rootViewController
}
var currentController:UIViewController?{
    guard let controller  =  rootController as? UINavigationController else {return nil}
    if  let visibleViewController = controller.visibleViewController{
        return visibleViewController
    }else{
        return controller
    }
}

var currentAlert:UIViewController?{
    guard let controller  =  rootController as? UINavigationController else {return nil}
    if  let visibleViewController = controller.visibleViewController{
        if let currentAlert = visibleViewController.presentedViewController as? UIAlertController{
            return currentAlert
        }else if let currentAlert = visibleViewController as? UIAlertController {
            return currentAlert
        }else{
            return visibleViewController
        }
        
    }else{
        if let currentAlert = controller.presentedViewController as? UIAlertController{
            return currentAlert
            
        }else{
            return controller
        }
    }
}
var alertMessage: String? {
    didSet{
        async {
            guard let controller  =  currentAlert else {return}
            if let alertController = controller as? UIAlertController{
                let messageFont  = OpenSans.Regular.font(size: 17)
                alertController.set(message: alertMessage, font: messageFont!, color: .white)
            }else{
                controller.showAlert(message: alertMessage)
            }
            
        }
    }
}

var userModel:WCUserModel?{
    set{
        guard let  model = newValue else { return }
        UserDefaults.set(archivedObject: model, forKey: kUserDataKey)
    }
    get{
        guard let model = UserDefaults.get(unarchiverObject: WCUserModel.self, forKey: kUserDataKey)else { return nil }
        return model
    }
    
}
var isLogin:Bool {
    if userModel != nil {
        return true
    }else{
        return false
    }
    
}

var accessToken:String{
    set{
        UserDefaults.set(object: "\(newValue)", forKey: kAuthTokenKey)
    }
    get{
        guard let accessToken = UserDefaults.getObject(forKey: kAuthTokenKey) as? String else { return "" }
        return accessToken
    }
}



let kTokenExpired = "The incoming token has expired"
let kUnauthorized = "Unauthorized"
var kAppImage:UIImage?          {get{ return Bundle.kAppIcon }}
var kAppTitle :String           {get{return Bundle.kAppTitle}}
let kConnectionError            = "No Internet Connection!☹"
let kDeviceTokenKey             = "DeviceTokenForSNS"
let kFirstTimeSubscriptionKey   = "FirstTimeSubscription"
let kUserDataKey                = "UserData"
let kAuthTokenKey               = "AuthToken"
let kNotAvaialable              = "Not Available"
let kSGBaseURLKey               = "SGBaseURl"

//Web Service Constant String-

var kBaseUrl               = "https://coagle.com/api/?action="




// Web Service name

var kLogin                    = "login"
var kReadersData              = "readers-data"
var kReaderProfile            = "reader-profile"



