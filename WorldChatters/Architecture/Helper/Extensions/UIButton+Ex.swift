//
//  UIButton+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
import Kingfisher
//MARK: - UIButton Extension
extension UIButton{
    
    //MARK: setter getter for button Image
    var normalImage:UIImage?{
        get{
            return self.image(for: .normal)
        }
        set{
            self.setImage(newValue, for: .normal)
        }
    }
    var selectedImage:UIImage?{
        get{
            return self.image(for: .selected)
        }
        set{
            self.setImage(newValue, for: .selected)
        }
    }
    var disabledImage:UIImage?{
        get{
            return self.image(for: .disabled)
        }
        set{
            self.setImage(newValue, for: .disabled)
        }
    }
    
    var highlightedImage:UIImage?{
        get{
            return self.image(for: .highlighted)
        }
        set{
            self.setImage(newValue, for: .highlighted)
        }
    }
    //MARK: setter getter for button BackgroundImage
    var normalBackgroundImage:UIImage?{
        get{
            return self.backgroundImage(for: .normal)
        }
        set{
            self.setBackgroundImage(newValue, for: .normal)
        }
    }
    
    var selectedBackgroundImage:UIImage?{
        get{
            return self.backgroundImage(for: .selected)
        }
        set{
            self.setBackgroundImage(newValue, for: .selected)
        }
    }
    var disabledBackgroundImage:UIImage?{
        get{
            return self.backgroundImage(for: .disabled)
        }
        set{
            self.setBackgroundImage(newValue, for: .disabled)
        }
    }
    var highlightedBackgroundImage:UIImage?{
        get{
            return self.backgroundImage(for: .highlighted)
        }
        set{
            self.setBackgroundImage(newValue, for: .highlighted)
        }
    }
    //MARK: setter getter for button title
    var normalTitle:String?{
        
        set{
            self.setTitle(newValue, for: .normal)
        }
        get{
            return self.title(for: .normal) ?? ""
        }
    }
    var selectedTitle:String?{
        get{
            return self.title(for: .selected) ?? ""
        }
        set{
            self.setTitle(newValue, for: .selected)
        }
    }
    var disabledTitle:String?{
        get{
            return self.title(for: .disabled) ?? ""
        }
        set{
            self.setTitle(newValue, for: .disabled)
        }
    }
    var highlightedTitle:String?{
        get{
            return self.title(for: .highlighted) ?? ""
        }
        set{
            self.setTitle(newValue, for: .highlighted)
        }
        
        
        
        
    }
    
    
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
        self.kf.cancelImageDownloadTask()
    }
    
    
    //FIXME: JITENDRA:- CRETEAD FUNC FOR UPDTAE BUTTON SIZE ACCORDING TO IMAGESIZE
    public func reloadImageSize(image:UIImage){
        let imageSize = image.size
        let aspect = imageSize.width/imageSize.height
        let size =  CGSize(width: self.frame.size.width, height: self.frame.size.width/aspect)
        self.frame.size.height = size.height
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    //MARK: - loadImage
    func loadImage(filePath:String,for state: UIControl.State, progressBlock: DownloadProgressBlock? = nil,onCompletion: ((_ image: Image?, _ error: Error?)->Swift.Void)? = nil ){
        if !NetworkState.state.isConnected {
            
            self.cancelDownloadTask()
            self.showLoader(isShow: false)
            return
        }
        self.showLoader(isShow: true)
        self.kf.setImage(with: URL(string: filePath), for: state, placeholder:nil, options: [.transition(.fade(1))], progressBlock: progressBlock , completionHandler: { (result) in
            async {
                switch result{
                case .success(let value):
                    
                    self.showLoader(isShow: false)
                    onCompletion?(value.image,nil)
                case .failure(let error):
                    self.showLoader(isShow: false)
                    onCompletion?(nil,error)
                    
                }
            }
        })
        
        
        
        
    }
    //MARK: - loadBackgroundImage
    func loadBackgroundImage(filePath:String,for state: UIControl.State, progressBlock: DownloadProgressBlock? = nil,onCompletion: ((_ image: Image?, _ error: Error?)->Swift.Void)? = nil){
        if !NetworkState.state.isConnected {
            
            self.cancelDownloadTask()
            self.showLoader(isShow: false)
            return
        }
        self.showLoader(isShow: true)
        //let process = ResizingImageProcessor.init(referenceSize: self.frame.size) ,.processor(process)
        self.kf.setBackgroundImage(with:URL(string: filePath), for: state, placeholder:nil, options: [.transition(.fade(1))], progressBlock: progressBlock , completionHandler: { (result) in
            
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
