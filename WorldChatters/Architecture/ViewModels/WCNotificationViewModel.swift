//
//  WCNotificationViewModel.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

class WCNotificationViewModel: NSObject {
  
    var objNotification:WCVideoChatModel?
    let readerViewModel =  WCReaderViewModel()
    
    init(parse: [String:Any]) {
        guard let data = JSONSerialization.JSONData(Object: parse) else { return}
        let result = data.JKDecoder(WCVideoChatAPNSResponse.self).object
        if let model = result?.object {
            objNotification = model
            
        }
       
    }
    var isOwner:Bool{
        guard let userID = userModel?.userID, let recieverID = self.objNotification?.receiverID else { return false }
        return userID == recieverID ? true :false
    }
    
}
















//class WCNotificationViewModel: NSObject {
//
//    var objNotification:WCVideoChatModel?
//    let readerViewModel =  WCReaderViewModel()
//
//    init(parse: [String:Any]) {
//        guard let data = JSONSerialization.JSONData(Object: parse) else { return}
//        let result = data.JKDecoder(WCVideoChatModel.self)
//        if let model = result.object {
//            objNotification = model
//
//        }
//
//    }
//    var isOwner:Bool{
//        guard let userID = userModel?.userID, let recieverID = self.objNotification?.receiverID else { return false }
//        return userID == recieverID ? true :false
//    }
//
//}
