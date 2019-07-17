//
//  UserViewModel.swift
//  WorldChatters
//
//  Created by Anuj Sharma on 18/06/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation
class UserViewModel:NSObject
{
    //MARK:- Login
    func login(email:String,password:String,onSuceess:@escaping() -> Void) {
        if !NetworkState.state.isConnected {
            return
        }
        if email.isEmpty{
            alertMessage = FieldValidation.kEmailEmpty
        }else if password.isEmpty{
            alertMessage = FieldValidation.kPasswordEmpty
        }else{
            let params = ["user_name":email, "password":password, "apiType":"wpType", "device_token":"423546567567734523234"]
            Server.Request.dataTask(method: .post) { (result) in
                switch result{
                case .success(let data, let code):
                    async {
                        SMUtility.shared.hideHud()
                        guard let response = data.JKDecoder(WCResponseModel<WCUserModel>.self).object else{return}
                        print("THE RESPONSE IS THE-------------->",response)
                        switch code{
                        case .OK:
                            
                            let isSuccess = response.isSuccess
                            if isSuccess{
                                guard let user = response.object else{return}
                                userModel = user
                                onSuceess()
                            }else{
                                alertMessage = response.message
                            }
                        case .Unauthorized:
                            DispatchQueue.main.async {
                                alertMessage = response.message
                                
                            }
                        default:
                            DispatchQueue.main.async {
                                SMUtility.shared.hideHud()
                                alertMessage = response.message
                                
                            }
                        }
                    }
                    
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        SMUtility.shared.hideHud()
                        alertMessage = error.localizedDescription
                        
                    }
                    
                }
            }.request(request: kBaseUrl + kLogin , headers: nil, params: params)
           

            
        }
    }
    
    
    
    
    
    
    
}
