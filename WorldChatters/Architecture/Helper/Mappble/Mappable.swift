//
//  Mappable.swift
//  CAD
//
//  Created by Jitendra Kumar on 25/01/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

// MARK: - JSON: Codable
typealias Mappable = Codable

extension Encodable{
    func JKEncoder() -> (data:Data?,error:Error?) {
        return JSNParser.encoder(self)
    }
    var jsonObject:[String:Any]?{
        if let data = JKEncoder().data {
            return data.object
        }else{
            return nil
        }
        
    }
    var jsonObjects:[[String:Any]]?{
        if let data = JKEncoder().data {
           return data.objects as? [[String:Any]]
        }else{
            return nil
        }
    }
    var jsonString:String?{
        if let data = JKEncoder().data {
           return data.utf8String
        }
        return nil
    }
   
}

extension Data{
    
    func JKDecoder<T>(_ type:T.Type)->(object:T?,error:Error?) where T:Decodable{
        return JSNParser.decoder(T.self, from: self)
    }
    var utf8String:String?{
        return String(bytes: self, encoding: .utf8)
    }
    var object:[String: Any]? {
        return JSONSerialization.JSONObject(data: self) as? [String : Any]
        
    }
    var objects:[Any]? {
        guard let listObject = JSONSerialization.JSONObject(data: self) as? [Any] else{return nil}
        return listObject
        
    }
}

private struct JSNParser:Equatable{
      
    static func decoder<T>(_ type:T.Type,from data:Data)->(object:T?,error:Error?) where T:Decodable{
        do{
            let decoder  = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let obj  = try decoder.decode(T.self, from: data)
            return (obj , nil)
        }catch {
            return (nil,error)
        }
    }
    static func encoder<T>(_ value: T)->(data:Data?,error:Error?) where T : Encodable{
        do{
            let encoder =  JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let encodeData  = try encoder.encode(value)
            return (encodeData,nil)
        }catch{
            return (nil,error)
        }
    }
}

