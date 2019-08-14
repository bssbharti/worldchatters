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
    @IBOutlet fileprivate var readerImageView: JKImageView!
    @IBOutlet fileprivate var readerNamelbl: UILabel!
    @IBOutlet fileprivate var readerStatuslbl: UILabel!
    @IBOutlet fileprivate var readerDescTV: UITextView!
    @IBOutlet fileprivate var readerEmaillbl: UILabel!
    var readerViewModel: WCReaderViewModel!
    var selectedIndexPath:IndexPath!
    @IBOutlet var tableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loadProfileData()
        
    }
    fileprivate func loadProfileData(){
        guard let indexPath = selectedIndexPath else { return  }
        readerViewModel.readerProfile(at: indexPath) {
            async {
                self.readerViewModel.realodReaderProfile(imageView: self.readerImageView, namelbl: self.readerNamelbl, statuslbl: self.readerStatuslbl, detailTV: self.readerDescTV ,emailLbl:self.readerEmaillbl)
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func audioBtn(_ sender: Any) {
        
        let vc = WCVideoChatVC.instance(from: .Main)
        vc.readerViewModel = readerViewModel
        vc.callerType = .sender
        vc.isNotifcation = false
        vc.callType = "audio"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func videoBtn(_ sender: Any) {
        let vc = WCVideoChatVC.instance(from: .Main)
        vc.readerViewModel = readerViewModel
        vc.callerType = .sender
        vc.isNotifcation = false
        vc.callType = "video"
        self.navigationController?.pushViewController(vc, animated: true)
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
