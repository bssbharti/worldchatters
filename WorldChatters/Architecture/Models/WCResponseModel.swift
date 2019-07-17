//
//  WCResponseViewModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 21/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation
struct WCResponseModel<T:Mappable>:Mappable{
    let status:String?
    let message:String?
    var code:Int?
    let object:T?
    enum CodingKeys:String,CodingKey {
        case status = "Status"
        case message = "msg"
        case object = "data"
        case code
    }
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        object = try values.decodeIfPresent(T.self, forKey: .object)
       
    }
    var isSuccess:Bool{
        guard let status = status else { return false }
        return status == "Success" ? true:false
    }
    func encoder(encoder:Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(message, forKey: .message)
        try container.encode(object, forKey: .object)
       
        
        
    }
    var statusCode:HTTPStatusCodes?{
        guard let code = self.code else { return nil }
        return HTTPStatusCodes(rawValue: code)
    }
}
