//
//  WCNotificationViewModel.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

class WCNotificationViewModel: NSObject {

  
    
    fileprivate var objNotification:WCNotificationModel?
    var badge:Int{
        return objNotification?.badge ?? 0
    }
    init(parse: [String:Any]) {
        
    }
}
