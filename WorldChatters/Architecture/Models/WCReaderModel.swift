//
//  WCReaderModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 24/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

struct WCReaderModel: Mappable {
    let readerID: String?
    let readerName: String?
    let userRole: String?
    let readerEmail: String?
    let readerImage: String?
    let deviceToken: String?
    let status:String?
    let description:String?
    enum CodingKeys:String,CodingKey {
        case readerID = "readerId"
        case readerName = "readerName"
        case readerEmail = "readerEmail"
        case readerImage = "readerImage"
        case deviceToken = "device_token"
        case userRole = "user_role"
        case status = "status"
        case description
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        readerID = try? values.decodeIfPresent(String.self, forKey: .readerID)
        readerName = try? values.decodeIfPresent(String.self, forKey: .readerName)  ?? ""
        readerEmail = try? values.decodeIfPresent(String.self, forKey: .readerEmail)  ?? ""
        readerImage = try? values.decodeIfPresent(String.self, forKey: .readerImage)  ?? ""
        deviceToken = try? values.decodeIfPresent(String.self, forKey: .deviceToken)  ?? ""
        userRole = try? values.decodeIfPresent(String.self, forKey: .userRole) ?? ""
        status = try? values.decodeIfPresent(String.self, forKey: .status)  ?? ""
        description = try? values.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
    
   
}
