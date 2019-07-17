//
//  WCReaderProfileViewModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 10/07/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation

class WCReaderProfileViewModel:NSObject
{
    func readerProfile(userId:String = "51",completionHandler:@escaping()->Void){
        
        guard NetworkState.state.isConnected else {
            return
        }
        
        SMUtility.shared.showHud()
        Server.Request.dataTask(method: .post) { (result) in
            async {
                SMUtility.shared.hideHud()
                switch result{
                case .success(let data, let code):
                    
                    guard let response = data.JKDecoder(WCResponseModel<[WCReaderProfileModel]>.self).object else{return}
                    switch code{
                    case .OK:
                        if let list  = response.object{
                            
                        }
                        completionHandler()
                        
                    default:
                        alertMessage = response.message
                        
                    }
                case .failure(let error):
                    alertMessage = error.localizedDescription
                }
            }
            }.request(state: .default, request: kBaseUrl + kReaderProfile, headers: nil, params: ["userId":userId, "apiType":"wpType"])
        
        
    }
    
}
