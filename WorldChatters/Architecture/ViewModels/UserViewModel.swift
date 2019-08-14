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
            let token = AppDelegate.shared.getDeviceToken()
            let params = ["user_name":email, "password":password, "apiType":"wpType", "device_token":token]
            Server.Request.dataTask(method: .post) { (result) in
                switch result{
                case .success(let data, let code):
                    async {
                        SMUtility.shared.hideHud()
                        guard let response = data.JKDecoder(WCUserResponse.self).object else{return}
                        print("THE RESPONSE IS THE-------------->",response)
                        switch response.code{
                        case 200:
                                guard let user = response.object else{return}
                                
                                userModel = user
                                onSuceess()
                            
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
                    }
                    
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        SMUtility.shared.hideHud()
                        alertMessage = error.localizedDescription
                        
                    }
                    
                }
            }.request(request:  kLogin , headers: nil, params: params)
           

            
        }
    }
    
    
    
    
    
    
    
}
