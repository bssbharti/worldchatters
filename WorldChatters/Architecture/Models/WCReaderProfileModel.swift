//
//  WCReaderProfileModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 10/07/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation

struct WCReaderProfileResponse:Mappable
{
    let code: Int?
    let status, message: String?
    var object:WCReaderProfileModel?
    
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
        object   = try values.decodeIfPresent(WCReaderProfileModel.self, forKey: .object)
        
    }
    
}

struct WCReaderProfileModel: Mappable
{
    let id:String?
    let name:String?
    let email:String?
    let userRole:String?
    let device_token:String?
    enum CodingKeys:String,CodingKey {
        case id = "readerId"
        case name = "readerName"
        case email = "readerEmail"
        case userRole = "user_role"
        case device_token = "device_token"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        userRole = try values.decodeIfPresent(String.self, forKey: .userRole)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
    }
    
    func encoder(encoder:Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(userRole, forKey: .userRole)
        try container.encode(device_token, forKey: .device_token)
    }
}
