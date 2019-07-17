//
//  NetworkState.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Alamofire
class NetworkState {
  
    class var state:NetworkState{
        struct  Singlton{
            static let instance = NetworkState()
        }
        return Singlton.instance
    }
    var isConnected:Bool {
        let isReachable = NetworkReachabilityManager()!.isReachable
        if !isReachable {
            DispatchQueue.main.async {
                SMUtility.shared.hideHud()
                self.OpenWifiSetting(Completion: { (index) in
                    if index == 2{
                        if #available(iOS 10, *) {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                            
                        }
                        else{
                            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                        }
                    }
                })
                
            }
        }
        return isReachable
    }
    
    //MARK:- OpenWifiSetting
    fileprivate func OpenWifiSetting(Completion:@escaping(_ index:Int)->Void){
        
        let message = "The Internet connection appears to be offline.\(EmojiFont.sadEmoji)"
        guard let controller  =  currentAlert else {return}
        if let alertController = controller as? UIAlertController{
            let messageFont  = OpenSans.Regular.font(size: 17)
            alertController.set(message: message, font: messageFont!, color: .white)
        }else{
            controller.showAlertAction(title: kConnectionError, message: message , cancelTitle: "Cancel", otherTitle: "Settings!", onCompletion: Completion)
        }
    }
}
