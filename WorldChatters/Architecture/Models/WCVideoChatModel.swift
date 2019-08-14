//
//  WCVideoChatModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 23/07/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation

struct WCVideoChatRejectResponse:Mappable
{
    let code: Int?
    let status, message: String?
    var object:WCVideoChatModel?
    
    enum CodingKeys:String,CodingKey {
        case code
        case status    = "Status"
        case message   = "message"
        case object    = "data"
    }
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        code     = try values.decodeIfPresent(Int.self, forKey: .code)
        status   = try values.decodeIfPresent(String.self, forKey: .status)
        message  = try values.decodeIfPresent(String.self, forKey: .message)
        object   = try values.decodeIfPresent(WCVideoChatModel.self, forKey: .object)
        
    }
    
}


struct WCVideoChatResponse:Mappable
{
    let code: Int?
    let status, message: String?
    var object:WCVideoChatModel?
    
    enum CodingKeys:String,CodingKey {
        case code
        case status    = "Status"
        case message   = "message"
        case object    = "data"
    }
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        code     = try values.decodeIfPresent(Int.self, forKey: .code)
        status   = try values.decodeIfPresent(String.self, forKey: .status)
        message  = try values.decodeIfPresent(String.self, forKey: .message)
        object   = try values.decodeIfPresent(WCVideoChatModel.self, forKey: .object)
        
    }
    
}

struct WCVideoChatAPNSResponse:Mappable
{
    let aps, alert,sound : String?
    var object:WCVideoChatModel?
    
    enum CodingKeys:String,CodingKey {
        case aps    = "aps"
        case alert   = "alert"
        case sound    = "sound"
        case object    = "data"
    }
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        aps   = try values.decodeIfPresent(String.self, forKey: .aps)
        alert  = try values.decodeIfPresent(String.self, forKey: .alert)
        sound  = try values.decodeIfPresent(String.self, forKey: .sound)
        object   = try values.decodeIfPresent(WCVideoChatModel.self, forKey: .object)
        
    }
    
}

struct WCVideoChatModel: Mappable {
    var sessionId:String?
    var token:String?
    var callStatus:String?
    var senderID:String?
    var receiverID:String?
    var callerName:String?
    var callType:String?
    enum CodingKeys:String,CodingKey {
        case sessionId = "session_id"
        case token = "token"
        case callStatus = "call-status"
        case senderID = "caller_id"
        case receiverID = "receiver_id"
        case callerName = "caller_name"
        case callType   = "call_type"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        sessionId = try values.decodeIfPresent(String.self, forKey: .sessionId)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        callStatus = try values.decodeIfPresent(String.self, forKey: .callStatus)
        senderID = try values.decodeIfPresent(String.self, forKey: .senderID)
        receiverID = try values.decodeIfPresent(String.self, forKey: .receiverID)
        callerName = try values.decodeIfPresent(String.self, forKey: .callerName)
        callType = try values.decodeIfPresent(String.self, forKey: .callType)
    }
    var status:WCCallStatus?{
        guard let c = self.callStatus else {
            return .none
        }
        return WCCallStatus(rawValue: c)
    }
    init(_ redear:WCReaderModel) {
        self.receiverID = redear.readerID!
        self.senderID = userModel?.userID!
    }
    func encoder(encoder:Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sessionId, forKey: .sessionId)
        try container.encode(token, forKey: .token)
        try container.encode(callStatus, forKey: .callStatus)
    }
}
