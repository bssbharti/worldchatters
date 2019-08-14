//
//  JSONSerialization+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation
extension JSONSerialization{

    //MARK:- JSONObject-
    static func JSONObject(data:Data)->Any?{
        do{
            return try self.jsonObject(with:data, options: [])
        } catch  {
            print("json object conversion error%@",error.localizedDescription)
        }
        return nil
    }
    //MARK:- JSONStringify-
    static func JSONStringify(Object: Any, prettyPrinted: Bool = false) -> String
    {
        let options = prettyPrinted ? self.WritingOptions.prettyPrinted : self.WritingOptions(rawValue: 0)
        let isvalid = JSONSerialization.isValidJSONObject(Object)
        guard isvalid ,let data = try? JSONSerialization.data(withJSONObject: Object, options: options), let jsonString = String(data: data, encoding:.utf8)else { return "" }
        return jsonString
    }
    //MARK:- getJsonData-
    static func JSONData(Object:Any)->Data?{
        var data:Data?
        do{
            data = try self.data(withJSONObject: Object, options: [])
            
        } catch  {
            print("json error: \(error)")
        }
        return data
    }
}
