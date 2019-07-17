//
//  WCReaderProfileModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 10/07/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation

struct WCReaderProfileModel: Mappable {
    let id:Int?
    let name:String?
    let email:String?
    let readerImage:String?
    let device_token:String?
    enum CodingKeys:String,CodingKey {
        case id = "readerId"
        case name = "readerName"
        case email = "readerEmail"
        case readerImage = "readerImage"
        case device_token = "device_token"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        readerImage = try values.decodeIfPresent(String.self, forKey: .readerImage)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
    }
    
    func encoder(encoder:Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(readerImage, forKey: .readerImage)
        try container.encode(device_token, forKey: .device_token)
    }
}
