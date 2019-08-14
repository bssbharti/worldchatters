//
//  WCVideoChatVC.swift
//  WorldChatters
//
//  Created by Sunil Garg on 04/07/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
import OpenTok



let kWidgetHeight = 240
let kWidgetWidth = 320

class WCVideoChatVC: UIViewController {
    
    
    fileprivate lazy var publisher: OTPublisher = {
        let settings = OTPublisherSettings()
        
        settings.name = UIDevice.current.name
        return OTPublisher(delegate: self, settings: settings)!
    }()
    fileprivate var subscriber: OTSubscriber?
    fileprivate var callStatus:WCCallStatus  = .none
    @IBOutlet var videoChatViewModel: WCVideoChatViewModel!
    var isStreamCreated:Bool = false
    
    var readerViewModel: WCReaderViewModel!
    var isNotifcation:Bool = false
    var callerType:WCCallerType  = .sender
    var callType = ""
    
    @IBOutlet fileprivate var remoteVideo: UIView!
    @IBOutlet fileprivate var localVideo: UIView!
    @IBOutlet var callConnectBtn: UIButton!
    @IBOutlet var callStatusLbl: UILabel!
    @IBOutlet var callBackgroundImage: UIImageView!
    @IBOutlet var callUserNameLbl: UILabel!
    
    
    let customAudioDevice = DefaultAudioDevice()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadViewChatData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    fileprivate func loadViewChatData(){
        
        if !isNotifcation {
            guard let readerVM = self.readerViewModel else {return}
            
            self.callConnectBtn.setImage(nil, for: .normal)
            callConnectBtn.isUserInteractionEnabled = false
            callStatusLbl.text                      = "Calling..."
            localVideo.isHidden                     = true
            remoteVideo.isHidden                    = true
            callUserNameLbl.text                    = readerViewModel.readerModel?.readerName
            isStreamCreated                         = true
            
            videoChatViewModel.setReaderView(readerVM) {
                //                switch self.callerType {
                //                case .sender:
                self.videoChatViewModel.videoCallInitiate(calltype: self.callType) {
                  
                   DispatchQueue.main.async {
                        self.callStatus = self.videoChatViewModel.callStatus
                        print("------- Succelfully dadasdasdasd kmaklsmd==--- ----------")
                        OTAudioDeviceManager.setAudioDevice(self.customAudioDevice)
                        self.doConnect()
                        
                    }
                }
                
                
                
                //                default:
                //                    break
                //                }
                
            }
        }else{
            //            switch self.callerType {
            //            case .sender:
            //                self.videoChatViewModel.videoCallInitiate {
            //                    DispatchQueue.main.async {
            //                        self.callStatus = self.videoChatViewModel.callStatus
            //                        print("------- Succelfully dadasdasdasd kmaklsmd==--- ----------")
            //
            //                        self.doConnect()
            //
            //                    }
            //                }
            //            case .receiver:
            //                self.callStatus = self.videoChatViewModel.callStatus
            //                print("------- Succelfully dadasdasdasd kmaklsmd==--- ----------")
            
            
            callConnectBtn.isUserInteractionEnabled = true
            localVideo.isHidden                     = true
            remoteVideo.isHidden                    = true
            callStatusLbl.text                      = "Incoming Call..."
            callUserNameLbl.text                    = videoChatViewModel.videoChatModel?.callerName
            
            
            
            //            }
            
        }
        
        
    }
    func callDisconnect()
    {
        self.navigationController?.popViewController(animated: true)
        //        var error: OTError?
        //        guard let session = videoChatViewModel.session else { return  }
        //        session.disconnect(&error)
        //        videoChatViewModel.videoCallReject {
        //
        //        }
    }
    @IBAction func callConnectBtn(_ sender: Any){
        self.callConnectBtn.setImage(nil, for: .normal)
        callConnectBtn.isUserInteractionEnabled = false
        OTAudioDeviceManager.setAudioDevice(self.customAudioDevice)
        self.doConnect()
    }
    @IBAction func disconnectBtn(_ sender: Any) {
        var error: OTError?
        guard let session = videoChatViewModel.session else { return  }
        session.disconnect(&error)
        
        videoChatViewModel.videoCallReject {
            if self.isStreamCreated == false
            {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    /**
     * Asynchronously begins the session connect process. Some time later, we will
     * expect a delegate method to call us back with the results of this action.
     */
    fileprivate func doConnect() {
        if callType == "audio" {
            publisher.publishVideo = false
        }
        else{
            publisher.publishVideo = true
        }
        
        guard let session = videoChatViewModel.session else { return  }
        if session.delegate == nil {
            session.delegate = self
        }
        
        var error: OTError?
        defer {
            processError(error)
        }
        
        session.connect(withToken: videoChatViewModel.videoSessionToken!, error: &error)
    }
    
    /**
     * Sets up an instance of OTPublisher to use with this session. OTPubilsher
     * binds to the device camera and microphone, and will provide A/V streams
     * to the OpenTok session.
     */
    fileprivate func doPublish() {
        guard let session = videoChatViewModel.session else { return  }
        var error: OTError?
        defer {
            processError(error)
        }
        
        session.publish(publisher, error: &error)
        
        if let pubView = publisher.view {
            pubView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
            localVideo.addSubview(pubView)
        }
    }
    
    /**
     * Instantiates a subscriber for the given stream and asynchronously begins the
     * process to begin receiving A/V content for this stream. Unlike doPublish,
     * this method does not add the subscriber to the view hierarchy. Instead, we
     * add the subscriber only after it has connected and begins receiving data.
     */
    fileprivate func doSubscribe(_ stream: OTStream) {
        if callType == "audio" {
            subscriber?.subscribeToVideo = false
        }
        else{
            subscriber?.subscribeToVideo = true
        }
        
        
        guard let session = videoChatViewModel.session else { return  }
        var error: OTError?
        defer {
            processError(error)
        }
        subscriber = OTSubscriber(stream: stream, delegate: self)
        
        session.subscribe(subscriber!, error: &error)
    }
    
    fileprivate func cleanupSubscriber() {
        subscriber?.view?.removeFromSuperview()
        subscriber = nil
    }
    
    fileprivate func cleanupPublisher() {
        publisher.view?.removeFromSuperview()
    }
    
    fileprivate func processError(_ error: OTError?) {
        if let err = error {
            DispatchQueue.main.async {
                let controller = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
// MARK: - OTSession delegate callbacks
extension WCVideoChatVC: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
        print("Session connected")
        doPublish()
    }
    
    func sessionDidDisconnect(_ session: OTSession) {
        print("Session disconnected")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {
        print("Session streamCreated: \(stream.streamId)")
        isStreamCreated = true
        
        if callType == "audio" {
            callStatusLbl.text            = "Connected"
            callStatusLbl.isHidden        = false
            callBackgroundImage.isHidden  = false
            localVideo.isHidden           = true
            remoteVideo.isHidden          = true
            callUserNameLbl.isHidden      = false
        }
        else{
            callStatusLbl.isHidden        = true
            callBackgroundImage.isHidden  = true
            localVideo.isHidden           = false
            remoteVideo.isHidden          = false
            callUserNameLbl.isHidden      = true
        }
        
        
        if subscriber == nil {
            doSubscribe(stream)
        }
    }
    
    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
        print("Session streamDestroyed: \(stream.streamId)")
        if let subStream = subscriber?.stream, subStream.streamId == stream.streamId {
            cleanupSubscriber()
        }
    }
    
    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("session Failed to connect: \(error.localizedDescription)")
    }
    
}

// MARK: - OTPublisher delegate callbacks
extension WCVideoChatVC: OTPublisherDelegate {
    func publisher(_ publisher: OTPublisherKit, streamCreated stream: OTStream) {
        print("Publishing")
    }
    
    func publisher(_ publisher: OTPublisherKit, streamDestroyed stream: OTStream) {
        cleanupPublisher()
        if let subStream = subscriber?.stream, subStream.streamId == stream.streamId {
            cleanupSubscriber()
        }
    }
    
    func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
        print("Publisher failed: \(error.localizedDescription)")
    }
}

// MARK: - OTSubscriber delegate callbacks
extension WCVideoChatVC: OTSubscriberDelegate {
    func subscriberDidConnect(toStream subscriberKit: OTSubscriberKit) {
        
        print("Subscriber")
        
        if let subsView = subscriber?.view {
            subsView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            remoteVideo.addSubview(subsView)
        }
    }
    
    func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
        print("Subscriber failed: \(error.localizedDescription)")
    }
    func subscriberVideoDataReceived(_ subscriber: OTSubscriber) {
         print("Subscriber -------------- Video ------------- Data Recieved")
    }
    
 
}

//extension WCVideoChatVC: OTAudioDevice {
//    func captureFormat() -> OTAudioFormat {
//        <#code#>
//    }
//
//    func renderFormat() -> OTAudioFormat {
//        <#code#>
//    }
//
//    func renderingIsAvailable() -> Bool {
//        <#code#>
//    }
//
//    func initializeRendering() -> Bool {
//        <#code#>
//    }
//
//    func renderingIsInitialized() -> Bool {
//        <#code#>
//    }
//
//    func startRendering() -> Bool {
//        <#code#>
//    }
//
//    func stopRendering() -> Bool {
//        <#code#>
//    }
//
//    func isRendering() -> Bool {
//        <#code#>
//    }
//
//    func estimatedRenderDelay() -> UInt16 {
//        <#code#>
//    }
//
//    func captureIsAvailable() -> Bool {
//        <#code#>
//    }
//
//    func initializeCapture() -> Bool {
//        <#code#>
//    }
//
//    func captureIsInitialized() -> Bool {
//        <#code#>
//    }
//
//    func startCapture() -> Bool {
//        <#code#>
//    }
//
//    func stopCapture() -> Bool {
//        <#code#>
//    }
//
//    func isCapturing() -> Bool {
//        <#code#>
//    }
//
//    func estimatedCaptureDelay() -> UInt16 {
//        <#code#>
//    }
//
//
//    func setAudioBus(_ audioBus: OTAudioBus?) -> Bool {
//        return true
//    }
//}
