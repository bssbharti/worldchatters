//
//  HTTPHeader.swift
//  StrateGames
//
//  Created by Jitendra Kumar on 11/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Alamofire

enum HTTPHeader {
    
    enum Authorization {
        /// Returns a `Bearer` `Authorization` header using the `bearerToken` provided
        ///
        /// - Parameter bearerToken: The bearer token.
        /// - Returns:               The header.
        case `default`(value: String)
        /// Returns a `Bearer` `Authorization` header using the `bearerToken` provided
        ///
        /// - Parameter bearerToken: The bearer token.
        /// - Returns:               The header.
        case bearer(token: String)
        /// Returns a `Basic` `Authorization` header using the `username` and `password` provided.
        ///
        /// - Parameters:
        ///   - username: The username of the header.
        ///   - password: The password of the header.
        /// - Returns:    The header.
        case credential(username: String, password: String)
        private func authorization(_ value: String) -> HTTPHeaders {
            return ["Authorization":value]
        }
        var headers:HTTPHeaders{
            switch self{
            case .bearer(let token):return authorization("Bearer \(token)")
            case .credential(let username, let password):
                let credential = Data("\(username):\(password)".utf8).base64EncodedString()
                return authorization("Basic \(credential)")
            case .default(let value):return authorization(value)
                
                
            }
        }
        
    }
    /// Returns an `Accept-Charset` header.
    ///
    /// - Parameter value: The `Accept-Charset` value.
    /// - Returns:         The header.
    case acceptCharset(value: String)
    /// Returns an `Accept-Language` header.
    ///
    /// Alamofire offers a default Accept-Language header that accumulates and encodes the system's preferred languages.
    /// Use `HTTPHeader.defaultAcceptLanguage`.
    ///
    /// - Parameter value: The `Accept-Language` value.
    /// - Returns:         The header.
    case acceptLanguage(value: String)
    /// Returns an `Accept-Encoding` header.
    ///
    /// Alamofire offers a default accept encoding value that provides the most common values. Use
    /// `HTTPHeader.defaultAcceptEncoding`.
    ///
    /// - Parameter value: The `Accept-Encoding` value.
    /// - Returns:         The heade
    case acceptEncoding(value: String)
    case authorization(auth: Authorization)
    /// Returns a `Content-Disposition` header.
    ///
    /// - Parameter value: The `Content-Disposition` value.
    /// - Returns:         The header.
    case contentDisposition(value: String)
    
    /// Returns a `Content-Type` header.
    ///
    /// All Alamofire `ParameterEncoding`s set the `Content-Type` of the request, so it may not be necessary to manually
    /// set this value.
    ///
    /// - Parameter value: The `Content-Type` value.
    /// - Returns:         The header
    case contentType(value: String)
    
    /// Returns a `User-Agent` header.
    ///
    /// - Parameter value: The `User-Agent` value.
    /// - Returns:         The header.
    case userAgent(value: String)
    case custom(key:String,value:String)
    var headers:HTTPHeaders{
        switch self {
        case .acceptCharset(let value):         return ["Accept-Charset":value]
        case .acceptLanguage(let value):        return ["Accept-Language":value]
        case .acceptEncoding(let value):        return ["Accept-Encoding":value]
        case .authorization(let auth):          return auth.headers
        case .contentDisposition(let value):    return ["Content-Disposition":value]
        case .contentType(let value):           return ["Content-Type":value]
        case .userAgent(let value):             return ["User-Agent":value]
        case .custom(let key, let value):       return [key:value]
        }
    }
    
    
}



