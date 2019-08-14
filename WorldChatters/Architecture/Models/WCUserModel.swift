//
//  WCUserModel.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation

struct WCUserResponse:Mappable
{
    let code: Int?
    let status, message: String?
    var object:WCUserModel?
    
    enum CodingKeys:String,CodingKey {
        case code
        case status    = "Status"
        case message   = "msg"
        case object    = "data"
    }
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        code     = try values.decodeIfPresent(Int.self, forKey: .code)
        status   = try values.decodeIfPresent(String.self, forKey: .status)
        message  = try values.decodeIfPresent(String.self, forKey: .message)
        object   = try values.decodeIfPresent(WCUserModel.self, forKey: .object)
        
    }
    
}
struct WCUserModel:Mappable {
    var userID, userRole: String!
    var isVerified: Bool!
    var email, firstName, lastName, countryCode: String!
    var phoneNumber, dob, deviceToken: String!
    
    enum CodingKeys:String,CodingKey {
        case userID = "user_id"
        case userRole = "user_role"
        case isVerified, email, firstName, lastName, countryCode, phoneNumber, dob
        case deviceToken = "device_token"
    }
    
    init(from decoder:Decoder) throws {
        let container   = try decoder.container(keyedBy:CodingKeys.self)
        isVerified   = try? container.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
        email        = try? container.decodeIfPresent(String.self, forKey: .email) ?? ""
        firstName    = try? container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName     = try? container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        countryCode  = try? container.decodeIfPresent(String.self, forKey: .countryCode) ?? ""
        phoneNumber  = try? container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        dob          = try? container.decodeIfPresent(String.self, forKey: .dob) ?? ""
        userID       = try? container.decodeIfPresent(String.self, forKey: .userID) ?? ""
        deviceToken  = try? container.decodeIfPresent(String.self, forKey: .deviceToken) ?? ""
        userRole     = try? container.decodeIfPresent(String.self, forKey: .userRole) ?? ""
    }
    
    func encoder(encoder:Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try? container.encode(isVerified, forKey: .isVerified)
        try? container.encode(firstName, forKey: .firstName)
        try? container.encode(email, forKey: .email)
        try? container.encode(lastName, forKey: .lastName)
        try? container.encode(countryCode, forKey: .countryCode)
        try? container.encode(phoneNumber, forKey: .phoneNumber)
        try? container.encode(dob, forKey: .dob)
        try? container.encode(userID, forKey: .userID)
        try? container.encode(deviceToken, forKey: .deviceToken )
        try? container.encode(userRole, forKey: .userRole )
        
    }
    
    
}

