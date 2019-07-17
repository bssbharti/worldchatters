//
//  WCReaderProfileVC.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
import OpenTok

class WCReaderProfileVC: UIViewController {
    
    @IBOutlet fileprivate var readerProfileViewModel: WCReaderProfileViewModel!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readerProfileViewModel.readerProfile {
            async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func videoBtn(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WCVideoChatVC") as? WCVideoChatVC
//        self.present(vc!, animated: true, completion: nil)
    }
}

extension WCReaderProfileVC:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WCReadersCell", for: indexPath) as! WCReadersCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
    }
    
}
