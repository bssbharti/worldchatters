//
//  WCReaderViewModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 24/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

class WCReaderViewModel: NSObject {

    var readerModel:WCReaderModel?
    fileprivate var readers:[WCReaderModel] = []
    func readers(completionHandler:@escaping()->Void){
        
        guard NetworkState.state.isConnected else {
            return
        }
        SMUtility.shared.showHud()
        Server.Request.dataTask(method: .post) { (result) in
            async {
                SMUtility.shared.hideHud()
                switch result{
                case .success(let data, let code):
               
                    guard let response = data.JKDecoder(WCResponseModel<[WCReaderModel]>.self).object else{return}
                    switch code{
                    case .OK:
                        if let list  = response.object{
                            self.readers = list
                        }
                        completionHandler()
                        
                    default:
                        alertMessage = response.message
                        
                    }
                  case .failure(let error):
                    alertMessage = error.localizedDescription
                }
            }
            }.request(state: .default, request:  kReadersData, headers: nil, params: ["cat_id":"2", "apiType":"wpType"])
       
    }
    
    func readerProfile(at indexPath:IndexPath,completionHandler:@escaping()->Void){
        
        let obj  = self[at: indexPath]
        guard NetworkState.state.isConnected, let readerID = obj.readerID else {
            return
        }
        
        SMUtility.shared.showHud()
        Server.Request.dataTask(method: .post) { (result) in
            async {
                SMUtility.shared.hideHud()
                switch result{
                case .success(let data, let code):
                    
                    guard let response = data.JKDecoder(WCResponseModel<WCReaderModel>.self).object else{return}
                    switch response.code{
                    case 200:
                        if let object  = response.object{
                            self.readerModel = object
                            completionHandler()
                        }
                        
                    case 400:
                        DispatchQueue.main.async {
                            alertMessage = response.message
                            
                        }
                    case 201:
                        DispatchQueue.main.async {
                            alertMessage = response.message
                            
                        }
                    default:
                        DispatchQueue.main.async {
                            SMUtility.shared.hideHud()
                            alertMessage = response.message
                            
                        }
                    }
                    
                    
                case .failure(let error):
                    alertMessage = error.localizedDescription
                }
            }
            }.request(state: .default, request:  kReaderProfile, headers: nil, params: ["userId":readerID, "apiType":"wpType"])
        
        
    }
    
    
}
extension WCReaderViewModel{
    subscript(at indexPath:IndexPath)->WCReaderModel{
        
        return self.readers[indexPath.row]
    }
    var count:Int{
        return self.readers.count
    }
    
    func realodReaderProfile(imageView:JKImageView, namelbl:UILabel,statuslbl:UILabel,detailTV:UITextView,emailLbl:UILabel){
        guard let obj = self.readerModel else { return  }
        
        if let imagePath = obj.readerImage {
            imageView.loadImage(filePath: imagePath)
        }
        else{
            imageView.image =  UIImage(named: "profile_icon")!
        }
        namelbl.text = obj.readerName ?? ""
        statuslbl.text = obj.status ?? "offline"
        detailTV.text = obj.description ?? "I am passionate about my work."
        emailLbl.text = obj.readerEmail ?? ""
        
    }
    var readerId:String?{
        return readerModel?.readerID
    }
    
    
}
