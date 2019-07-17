//
//  UIImageView+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
import Kingfisher


//MARK: - UIImageView Extension

extension UIImageView{
    
    fileprivate func showLoader(isShow:Bool){
        if isShow {
            let loader = JKIndicatorView()
            loader.lineColor = JKColor.Teal
            loader.lineWidth = 2
            loader.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(loader)
            loader.centerInSuperview(size: .init(width: 25, height: 25))
            loader.startAnimation()
        }else{
            guard let loader = self.subviews.first(where: {$0.isKind(of: JKIndicatorView.self)}) as? JKIndicatorView else{return}
            async {
                loader.stopAnimation()
                loader.removeFromSuperview()
            }
        }
    }
   public func cancelDownloadTask(){
        self.kf.cancelDownloadTask()
    }

    public func reloadImageSize(image:UIImage){
        let imageSize = image.size
        let aspect = imageSize.width/imageSize.height
        let size =  CGSize(width: self.frame.size.width, height: self.frame.size.width/aspect)
        self.frame.size.height = size.height
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
   public func loadImage(filePath:String, progressBlock: DownloadProgressBlock? = nil,onCompletion: ((_ image: Image?, _ error: Error?)->Swift.Void)? = nil ){
    if !NetworkState.state.isConnected {
        
        self.cancelDownloadTask()
        self.showLoader(isShow: false)
        return
    }
    self.showLoader(isShow: true)
    self.kf.setImage(with: URL(string: filePath), placeholder: nil, options: [.transition(.fade(1))], progressBlock: progressBlock, completionHandler: { (result) in
        switch result{
        case .success(let value):
            self.showLoader(isShow: false)
            onCompletion?(value.image,nil)
        case .failure(let error):
            self.showLoader(isShow: false)
            onCompletion?(nil,error)
            
            
            
        }
    })
    
        
        
    }
    
}
