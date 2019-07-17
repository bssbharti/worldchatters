//
//  SMSession.swift
//  StrateGames
//
//  Created by Jitendra Kumar on 24/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation
import Alamofire
enum SMSessionState:Int{
    case `default`
    case background
    var session:Alamofire.SessionManager{
        return SMSession.shared.currentSession(self)
    }
    func cancelRequest(_ url:String){
        session.request(url).cancel()
    }
    
}
class SMSession: NSObject {
    //MARK:-documentsDirectoryURL-
    static let shared = SMSession()
    lazy var documentsDirectoryURL : URL = {
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documents
    }()
    fileprivate lazy var backgroundManager: Alamofire.SessionManager = {
        let bundleIdentifier = Bundle.main.bundleIdentifier
        let configure  = URLSessionConfiguration.background(withIdentifier: bundleIdentifier! + ".background")
        // configure.timeoutIntervalForRequest = 30
        let session = Alamofire.SessionManager(configuration:configure)
        session.startRequestsImmediately = true
        return session
    }()
    fileprivate lazy var sessionManager: Alamofire.SessionManager = {
        
        let configure  = URLSessionConfiguration.default
        configure.timeoutIntervalForRequest = 30
        return Alamofire.SessionManager(configuration: configure)
    }()
    func currentSession(_ state:SMSessionState = .default)->Alamofire.SessionManager{
        switch state {
        case .background:return backgroundManager
           
        default: return sessionManager
            
        }
    }

 
}

extension DataRequest{
    fileprivate func decodableResponseSerializer<T: Mappable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            let rs = data.JKDecoder(T.self)
            if let err = rs.error{
                return .failure(err)
            }else{
                 return Result { rs.object!}
            }
           
            
        }
    }
    
    @discardableResult
    func responseDecodable<T: Mappable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    
}

