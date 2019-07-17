//
//  WCUserModel.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation


struct WCUserModel:Mappable {
    let isVerified:Bool?
    let email:String?
    let firstName:String?
    let lastName:String?
    let countryCode:String?
    let phoneNumber:String?
    let dob:String?
    let userID:String?
    let device_token:String?
    
    enum CodingKeys:String,CodingKey {
        case isVerified = "isVerified"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case countryCode = "countryCode"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case userID = "user_id"
        case device_token = "device_token"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        isVerified = try values.decodeIfPresent(Bool.self, forKey: .isVerified)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        userID = try values.decodeIfPresent(String.self, forKey: .userID)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
    }
    
    func encoder(encoder:Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isVerified, forKey: .isVerified)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(email, forKey: .email)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(dob, forKey: .dob)
        try container.encode(userID, forKey: .userID)
        try container.encode(device_token, forKey: .device_token )
        
    }
    
    
}

