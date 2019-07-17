//
//  UIViewController.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit


//MARK: - UIViewController Extension -
extension UIViewController{
    static var storyboardID:String{
        return String(describing: self)
    }
    static func instance(from storyboard:AppStoryboard)->Self{
        return storyboard.viewController(viewController: self)
    }
   static func instance(from storyboard:AppStoryboard,withIdentifier identifier :String)->Self{
        return storyboard.viewController(withIdentifier: identifier)
    }
    //MARK: - modalPresentation -
    func modalPresentation(){
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
    }
    
    //MARK: - modalFromSheet -
    func modalFromSheet(){
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .formSheet
    }
    
    //MARK: - zoomBounceAnimation -
    func zoomBounceAnimation(containtView popUp:UIView){
        popUp.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        
        UIView.animate(withDuration: 0.3/1.5, animations: {
            popUp.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (finished) in
            UIView.animate(withDuration: 0.3/2, animations: {
                popUp.transform = CGAffineTransform(scaleX:  0.9, y:  0.9)
            }) { (finished) in
                UIView.animate(withDuration: 0.3/2, animations: {
                    popUp.transform = .identity
                })
            }
        }
        
    }
    //MARK: - fadeAnimationController -
    func fadeAnimationController(duration:TimeInterval = 0.5,completion: ((Bool) -> Swift.Void)? = nil ){
        self.view.alpha = 0
        UIView.transition(with: self.view, duration: duration, options: .transitionCrossDissolve, animations: {
            
            self.view.alpha = 1.0
            if (completion != nil) {
                completion!(true)
            }
        }) { (finished:Bool) in
            
        }
    }
    func showNotificationAlert(){
        self.showAlertAction(title: "\"\(kAppTitle)\" Notification disabled", message: "The app does not have access to your push notification. To enable access to push notification, tap \"Settings\" and turn on \"Allow Notifications.\"", cancelTitle: "OK", otherTitle: "Settings") { (index) in
            if index == 2{
                if #available(iOS 10, *) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                    
                }
                else{
                    UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
        }
        
    }
    //MARK: - showLogoutAlert -
    func showLogoutAlert(title:String = kAppTitle,message:String = "Are you sure you want to sign out?", completion: (() -> Swift.Void)? = nil){
        
        self.showAlertAction(title: title, message: message, cancelTitle: "NO", otherTitle: "YES") { (buttonIndex) in
            switch buttonIndex {
            case 2:
                
                if (completion != nil){
                    completion!()
                }
                break
                
            default:
                break
            }
        }
        
    }
    //MARK:- showAlert-
    func showAlertAction(title:String = kAppTitle,message:String?,cancelTitle:String = "Cancel",otherTitle:String = "OK",onCompletion:@escaping (_ didSelectIndex:Int)->Void){
        self.alertControl(title: title, message: message, cancelTitle: cancelTitle, otherTitle: otherTitle, onCompletion: onCompletion)
    }
    
    //MARK:- showAlert-
    func showAlert(title:String = kAppTitle,message:String?,completion:((_ didSelectIndex:Int)->Swift.Void)? = nil){
        
        self.alertControl(title: title, message: message, cancelTitle: "OK", otherTitle: nil, onCompletion: completion)
    }
    
    fileprivate func alertControl(title:String = kAppTitle,message:String?,cancelTitle:String = "OK",otherTitle:String?,onCompletion:((_ didSelectIndex:Int)->Swift.Void)? = nil){
        let titleFont  = OpenSans.Semibold.font(size: 20)
        let messageFont  = OpenSans.Regular.font(size: 17)
        let alertModel = AlertControllerModel(contentViewController: nil, title: title, message: message, titleFont: titleFont, messageFont: messageFont, titleColor: JKColor.DarkYellow, messageColor: .white, tintColor: JKColor.DarkYellow)
        var actions:[AlertActionModel] = [AlertActionModel]()
        let alertActionTitle = AlertActionTitle(title: cancelTitle, titleColor: .white)
        let cancel = AlertActionModel(actionIcon: nil, actionTitle: alertActionTitle, style: .cancel)
        actions.append(cancel)
        if let otherTitle = otherTitle {
            let alertActionTitle = AlertActionTitle(title: otherTitle, titleColor: JKColor.DarkYellow)
            let other = AlertActionModel(actionIcon: nil, actionTitle:alertActionTitle, style: .default)
            actions.append(other)
        }
        
        _ = UIAlertController.showAlert(from: self, controlModel: alertModel, actions: actions) { (alert:UIAlertController, action:UIAlertAction, index:Int) in
            if let handler = onCompletion {
                handler(index)
            }
            
        }
    }
    
    func setGradientView(){
        let gradientView = JKGradientView()
        gradientView.topColor = #colorLiteral(red: 0.7096659541, green: 0.8136398196, blue: 0.8764898181, alpha: 1)
        gradientView.bottomColor = #colorLiteral(red: 0.9655804038, green: 0.7753013968, blue: 0.7021818757, alpha: 1)
        view.addSubview(gradientView)
        gradientView.fillSuperview()
        self.view.subviews.forEach { (v) in
            if !v.isKind(of: JKGradientView.self){
                self.view.bringSubviewToFront(v)
            }
        }
       
    }
}

