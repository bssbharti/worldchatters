//
//  WCVideoChatViewModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 22/07/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation
import OpenTok
struct OpenTokKeys {
    // Replace with your OpenTok API key
   static var kApiKey = "46312072"
    // Replace with your OpenTok Secret key
   static var kSecretKey = "11b7132e5098886342639dcc832734cd95dca105"
//    // Replace with your generated session ID
//   static var kSessionId = "1_MX40NjMxMjA3Mn5-MTU2MzM5MzczNDMyMH5KWFJwSjBXYkZNT0xSbHl1eUNGRUFCOWN-fg"
//    // Replace with your generated token
//
//    // Publishers
//   static var kToken = "T1==cGFydG5lcl9pZD00NjMxMjA3MiZzaWc9YTM4NjUyNjAwY2YzZjY5YTYwZTM0MmEwY2UzMDM4NzBhOGI0MjE1NDpzZXNzaW9uX2lkPTFfTVg0ME5qTXhNakEzTW41LU1UVTJNek01TXpjek5ETXlNSDVLV0ZKd1NqQlhZa1pOVDB4U2JIbDFlVU5HUlVGQ09XTi1mZyZjcmVhdGVfdGltZT0xNTYzMzk2MjMxJm5vbmNlPTAuNjQwMjgxMTUyMTExMjY3JnJvbGU9cHVibGlzaGVyJmV4cGlyZV90aW1lPTE1NjU5ODgyMzAmaW5pdGlhbF9sYXlvdXRfY2xhc3NfbGlzdD0="
}

enum WCCallerType:String{
    case sender = "call_sender"
    case receiver = "call_receiver"
}
enum WCCallStatus:String {
    case connected = "connected"
    case disConnected = "disconnected"
    case connecting  = "connecting"
    case none  = "ideal"
}

class WCVideoChatViewModel:NSObject
{
   
    var videoChatModel:WCVideoChatModel?
    lazy var session: OTSession? = {
        let s =  OTSession(apiKey: OpenTokKeys.kApiKey , sessionId: videoSessionId!, delegate: nil)
        return s
    }()
    
    func videoCallInitiate(calltype:String ,completionHandler:@escaping()->Void){
        guard NetworkState.state.isConnected,let  model = videoChatModel ,let  receiverId = model.receiverID,let callerId = model.senderID else {
            return
        }
        
        SMUtility.shared.showHud()
        Server.Request.dataTask(method: .post) { (result) in
            async {
                SMUtility.shared.hideHud()
                switch result{
                case .success(let data, let code):
                    
                    guard let response = data.JKDecoder(WCVideoChatResponse.self).object else{return}
                    switch response.code{
                    case 200:
                        if let object  = response.object{
                            if self.videoChatModel == nil{
                                 self.videoChatModel = object
                            }else{
                                 self.videoChatModel?.sessionId = object.sessionId
                                self.videoChatModel?.token   = object.token
                                self.videoChatModel?.callStatus = object.callStatus
                            }
                           
                            completionHandler()
                        }
                        
                    case 400:
                        DispatchQueue.main.async {
                            alertMessage = response.message
                            
                        }
                    case 201:
                        DispatchQueue.main.async {
                            alertMessage = response.message
                            
                        }
                    default:
                        DispatchQueue.main.async {
                            SMUtility.shared.hideHud()
                            alertMessage = response.message
                            
                        }
                    }
                    
                case .failure(let error):
                    alertMessage = error.localizedDescription
                }
            }
            }.request(request:  kCallInitiate, headers: nil, params: ["api_key":OpenTokKeys.kApiKey, "api_secret":OpenTokKeys.kSecretKey, "caller_id":callerId, "receiver_id":receiverId, "call_type":calltype , "apiType":"wpType"])
        
    }
    
    func videoCallReject(completionHandler:@escaping()->Void){
        
        guard NetworkState.state.isConnected,let sessionId = self.videoSessionToken, let  model = videoChatModel ,let  receiverId = model.receiverID,let callerId = model.senderID, let userRole = userModel?.userRole else {
            return
        }
        
        SMUtility.shared.showHud()
        Server.Request.dataTask(method: .post) { (result) in
            async {
                SMUtility.shared.hideHud()
                switch result{
                case .success(let data, let code):
                    
                    guard let response = data.JKDecoder(WCResponseModel<[WCVideoChatModel]>.self).object else{return}
                    switch code{
                    case .OK:
                        completionHandler()

                    default:
                        alertMessage = response.message

                    }
                case .failure(let error):
                    alertMessage = error.localizedDescription
                }
            }
            }.request(state: .default, request:  kCallReject, headers: nil, params: ["session_id":sessionId, "caller_id":callerId, "receiver_id":receiverId, "user_role":userRole, "apiType":"wpType"])
        
    }
   
}
extension WCVideoChatViewModel{
   
    var videoSessionId:String?{
          guard let obj = self.videoChatModel, let sessionID = obj.sessionId else { return nil}
        return sessionID
    }
    var videoSessionToken:String?{
        guard let obj = self.videoChatModel, let token = obj.token else { return nil}
        return token
    }
    var callStatus:WCCallStatus{
          guard let obj = self.videoChatModel, let status = obj.status else { return .none}
        return status
    }
    func setRedearData(_ obj:WCReaderModel){
        if videoChatModel == nil {
            videoChatModel = WCVideoChatModel(obj)
        }else{
            videoChatModel?.senderID = userModel?.userID!
            videoChatModel?.receiverID = obj.readerID
            
        }
    }
    func setReaderView(_ vm:WCReaderViewModel,completionHanlder:@escaping()->()){
        guard let model = vm.readerModel else {
            return
        }
        self.setRedearData(model)
        completionHanlder()
    }
    func setNotificationData(obj:WCVideoChatModel){
        self.videoChatModel = obj
    }
}
