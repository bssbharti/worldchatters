//
//  ServerManager.swift
//  StrateGames
//
//  Created by Jitendra Kumar on 17/05/19.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.

import UIKit
import Alamofire
enum SMResult<Value> {
    case success(Value,code:HTTPStatusCodes)
    case failure(Error)
    
}
typealias ServerManagerBlock = (_ result:SMResult<Data>)->Void
typealias SererManagerProgressBlock = (_ progress:Double?) -> Void

fileprivate class ServerManager: NSObject {
    
    class var shared:ServerManager{
        struct  Singlton{
            static let instance = ServerManager()
        }
        return Singlton.instance
    }
    
    var backgroundCompletionHandler: (() -> Void)? {
        get {
            return SMSessionState.background.session.backgroundCompletionHandler
        }
        set {
            SMSessionState.background.session.backgroundCompletionHandler = newValue
        }
    }
    
    var apiHeaders: HTTPHeaders? {
        if accessToken.isEmpty {return nil}
        return HTTPHeader.authorization(auth:.bearer(token:"\(accessToken)")).headers
    }
    
    
    //MARK:- onResponseBlock
   func responseTask(data:Data?,statusCode:Int,onCompletionHandler:@escaping ServerManagerBlock){
        if statusCode>=200,statusCode<300 {
            guard let status = HTTPStatusCodes(rawValue: statusCode), let data = data else{return}
            let result  = SMResult.success(data, code: status)
            onCompletionHandler(result)
        }else{
            guard let status  = HTTPStatusCodes(rawValue: statusCode) else{return}
            if status == .Unauthorized {
                if let data  = data{
                    let result  = SMResult.success(data, code: status)
                    onCompletionHandler(result)
                }else{
                    let localizedString = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                    let error  = SMError(localizedTitle: nil, localizedDescription: localizedString, code: statusCode)
                    onCompletionHandler(.failure(error))
                }
                
                
            }else{
                let localizedString =  HTTPURLResponse.localizedString(forStatusCode: statusCode)
                let error = SMError(localizedTitle: status.description, localizedDescription:localizedString, code: statusCode)
                onCompletionHandler(.failure(error))
            }
    }
}
    //MARK:-requestTask
     func requestTask(_ state:SMSessionState = .default,url:URLConvertible,method:HTTPMethod,params:[String:Any]?, headers: HTTPHeaders? = nil,onCompletionHandler:@escaping ServerManagerBlock){
        print("service name =\(url)")
        print("service params =\(String(describing: params))")
        state.session.request (url, method:method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            print("response\(response)")
            SMUtility.shared.showNetIndicator = false
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    self.responseTask(data: response.data, statusCode: response.response!.statusCode , onCompletionHandler: onCompletionHandler)
                    
                
                }
                break
                
            case .failure(let error):
                onCompletionHandler(.failure(error))
                
                break
                
            }
            }.resume()
        
        if state == .background {
            state.session.delegate.sessionDidFinishEventsForBackgroundURLSession = {
                session in
                // record the fact that we're all done moving stuff around
                // now, call the saved completion handler
                self.backgroundCompletionHandler?()
                self.backgroundCompletionHandler = nil
            }
            state.session.backgroundCompletionHandler = {
                // finshed task
            }
        }
        
    }
    //MARK:-uploadTask
     func uploadTask(_ state:SMSessionState = .default,url:URLConvertible,method:HTTPMethod,params:[String:Any]?,headers: HTTPHeaders? = nil ,multipartObject :[MultipartData]?,onCompletionHandler:@escaping ServerManagerBlock,progressHandler:SererManagerProgressBlock? = nil){
        guard let mediaList  = multipartObject, mediaList.count>0 else {
            self.requestTask(state, url: url, method: method, params: params, headers: headers, onCompletionHandler: onCompletionHandler)
            return
        }
    
        state.session.upload(multipartFormData: { (multipartFormData) in
            for object in mediaList{
                multipartFormData.append(object.media, withName: object.mediaUploadKey, fileName: object.fileName, mimeType: object.mimType)
            }
            if let parameter  = params{
                parameter.forEach({ (key,value) in
                    multipartFormData.append("\(value)".data(using:.utf8)!, withName: key)
                })
            }
            
        }, to: "\(url)",headers:headers, encodingCompletion: { (result) in
            SMUtility.shared.showNetIndicator = false
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                    if let progressHandler = progressHandler{
                        progressHandler(Progress.fractionCompleted)
                    }
                })
                upload.resume()
                upload.responseJSON { response in
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print("response\(response)")
                            self.responseTask(data: response.data, statusCode: response.response!.statusCode , onCompletionHandler: onCompletionHandler)
                        }
                        break
                        
                    case .failure(let err):
                        onCompletionHandler(.failure(err))
                        
                        break
                        
                    }
                }
                
            case .failure(let encodingError):
                onCompletionHandler(.failure(encodingError))
                
                
            }
        })
        if state == .background{
            state.session.delegate.sessionDidFinishEventsForBackgroundURLSession = {(session) in
          
                // record the fact that we're all done moving stuff around
                // now, call the saved completion handler
               
               
                
            }
            state.session.backgroundCompletionHandler = {
                // finshed task
                 self.backgroundCompletionHandler = nil
                 self.backgroundCompletionHandler?()
            }
        }
        
        
        
        
        
    }
    //MARK: - httpDelete -
    func httpDelete(_ state:SMSessionState = .default,request url:String,params:[String:Any]?, headers: HTTPHeaders? = nil,onCompletionHandler:@escaping ServerManagerBlock){
        self.requestTask(state, url: url, method: .delete, params: params, headers: headers, onCompletionHandler: onCompletionHandler)
    }
    // MARK:- httpPut -
    func httpPut(_ state:SMSessionState = .default,request url:String,params:[String:Any]?,headers: HTTPHeaders? = nil,onCompletionHandler:@escaping ServerManagerBlock){
        self.requestTask(state, url: url, method: .put, params: params, headers: headers, onCompletionHandler: onCompletionHandler)
    }
    //MARK:- httpPost -
    func httpPost(_ state:SMSessionState = .default,request url:String,params:Parameters?,headers: HTTPHeaders? = nil,onCompletionHandler:@escaping ServerManagerBlock){
        self.requestTask(state, url: url, method: .post, params: params, headers: headers, onCompletionHandler: onCompletionHandler)
    }
    //MARK:- httpGetRequest -
    func httpGet(_ state:SMSessionState = .default,request url:String,params:[String:Any]?,headers: HTTPHeaders? = nil ,onCompletionHandler:@escaping ServerManagerBlock){
        self.requestTask(state, url: url, method: .get, params: params, headers: headers, onCompletionHandler: onCompletionHandler)
    }
    //MARK:- httpUploadRequest -
    func httpUpload(_ state:SMSessionState = .default,request url:String,params:[String:Any]?,headers: HTTPHeaders? = nil ,multipartObject :[MultipartData]?,onCompletionHandler:@escaping ServerManagerBlock,progressHandler:SererManagerProgressBlock? = nil){
        self.uploadTask(state, url: url, method: .post, params: params, headers: headers, multipartObject: multipartObject, onCompletionHandler: onCompletionHandler, progressHandler: progressHandler)
        
    }
    //MARK:- httpDownloadRequest -
    func httpDownload(_ state:SMSessionState = .default,request api:String ,onCompletionHandler:@escaping (_ result : SMResult<URL?>)->Void,progressHandler:SererManagerProgressBlock? = nil){
        print("\(api)")
        guard let fileUrl  = URL(string: "\(api)") else {
            let errorTemp = SMError(localizedTitle: "file url incorrect", localizedDescription: "file url incorrect", code: 500)
            onCompletionHandler(.failure(errorTemp))
            return
        }
        let request = URLRequest(url: fileUrl)
        let destination: DownloadRequest.DownloadFileDestination = { filePath,response in
            let directory  = SMSession.shared.documentsDirectoryURL
            let fileURL =   directory.appendingPathComponent(response.suggestedFilename!)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        state.session.download(request, to: destination).response(completionHandler: { (response:DefaultDownloadResponse) in
            SMUtility.shared.showNetIndicator = false
            if let error = response.error {
                onCompletionHandler(.failure(error))
            }
            else{
                
                guard let code = response.response?.statusCode, let status  = HTTPStatusCodes(rawValue: code)else{return}
                switch status{
                case .OK:
                    
                    onCompletionHandler(.success(response.destinationURL, code: status))
                case .Unauthorized:
                    let localizedString = HTTPURLResponse.localizedString(forStatusCode: code)
                    let error  = SMError(localizedTitle: nil, localizedDescription: localizedString, code: code)
                    onCompletionHandler(.failure(error))
                default:
                    let localizedString = HTTPURLResponse.localizedString(forStatusCode: code)
                    let error  = SMError(localizedTitle: nil, localizedDescription: localizedString, code: code)
                    onCompletionHandler(.failure(error))
                }
                
            }
            
        }).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
            if let onProgress = progressHandler {
                onProgress(progress.fractionCompleted)
            }
            }.resume()
        
        if state == .background{
            state.session.delegate.sessionDidFinishEventsForBackgroundURLSession = {
                session in
                // record the fact that we're all done moving stuff around
                // now, call the saved completion handler
                self.backgroundCompletionHandler?()
                self.backgroundCompletionHandler = nil
            }
            state.session.backgroundCompletionHandler = {
                // finshed task
            }
        }
        
        
    }
    
    
}


extension AppDelegate{
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        let bundleIdentifier = Bundle.main.bundleIdentifier!+".background"
        if application.backgroundRefreshStatus == .available , identifier == bundleIdentifier{
            ServerManager.shared.backgroundCompletionHandler = completionHandler
        }else{
            alertMessage = "Please enable the background mode before refreshing the data in background."
        }
        
    }
}

struct Server {
    static func backgroundCompletionHandler(_ compltion: (() -> Void)?) {
        ServerManager.shared.backgroundCompletionHandler = compltion
    }
    enum Request {
        case dataTask(method:HTTPMethod,completionHandler:ServerManagerBlock)
        case  uploadTask(data:[MultipartData],completionHandler:ServerManagerBlock,progressHandler:SererManagerProgressBlock?)
        case  downloadTask(completionHandler:(_ result:SMResult<URL?>)->Void,progressHandler:SererManagerProgressBlock?)
        func request(state:SMSessionState = .default, request:String,headers: HTTPHeaders? = nil, params:Parameters? = nil) {
            switch self {
            case .dataTask(let method, let completionHandler):
                ServerManager.shared.requestTask(state, url: request, method: method, params: params, headers: headers, onCompletionHandler: completionHandler)
            case .uploadTask(let data, let completionHandler,let progressHandler):
                ServerManager.shared.httpUpload(state,request: request, params: params, multipartObject: data, onCompletionHandler: completionHandler,progressHandler:progressHandler)
            case .downloadTask(let completionHandler, let progressHandler):
                ServerManager.shared.httpDownload(state,request: request,onCompletionHandler: completionHandler, progressHandler: progressHandler)
            }
      
        }
        
        
    }
    
    
}

