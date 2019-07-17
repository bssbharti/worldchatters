//
//  WCLoginVC.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit

class WCLoginVC: UIViewController {
    @IBOutlet fileprivate weak var emailTF:JKTextField!
    @IBOutlet fileprivate weak var passwordTF:JKTextField!
    
    @IBOutlet var objUserViewModel: UserViewModel!
    
    override func loadView() {
        super.loadView()
        self.setGradientView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        // Do any additional setup after loading the view.
    }
    
    @IBAction fileprivate func onSingin(_ sender:Any){
        guard let email = emailTF.text , let password = passwordTF.text else { return  }
        objUserViewModel.login(email: email, password: password, onSuceess: {
            AppDelegate.shared.showMainController()
            
        })
    }
    

}
