//
//  WCReaderViewModel.swift
//  WorldChatters
//
//  Created by Sunil Garg on 24/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

class WCReaderViewModel: NSObject {

    fileprivate var readers:[WCReaderModel] = []
    func readers(catId:String = "2",completionHandler:@escaping()->Void){
        
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
            }.request(state: .default, request: kBaseUrl + kReadersData, headers: nil, params: ["cat_id":catId, "apiType":"wpType"])
        
    }
}
extension WCReaderViewModel{
    subscript(at indexPath:IndexPath)->WCReaderModel{
        return self.readers[indexPath.row]
    }
    var count:Int{
        return self.readers.count
    }
}
