//
//  AppDelegate.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import AudioToolbox
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        if !Platform.isSimulator{
            registerApns(application: application)
        }
        setNavigationBar()
        //        showMainController()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
}

extension AppDelegate {
    static var shared: AppDelegate {return UIApplication.shared.delegate as! AppDelegate}
    func setNavigationBar(showBarColor:Bool = false)
    {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        if let font : UIFont = OpenSans.Semibold.font(size: 20){
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor : UIColor.white]
        }
        
        //UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4962375383)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "ic_back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "ic_back")
        if let nav  = rootController as? UINavigationController{
            
            if showBarColor{
                UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4962375383)
                let bgImage  = UIImage.getImageWithColor(color:  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4962375383), size: nav.navigationBar.frame.size) ?? UIImage()
                UINavigationBar.appearance().setBackgroundImage(bgImage, for: .default)
            }else{
                UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            }
            
        }
        UINavigationBar.appearance().shadowImage = UIImage()
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: -220), for:.default)
        
    }
}
extension AppDelegate{
    
    func checkApnsPermission(onCompletion:((Bool) -> Swift.Void)? = nil){
        
        if isNotificationEnabled {
            
            if #available(iOS 10.0, *) {
                let current = UNUserNotificationCenter.current()
                current.getNotificationSettings { (settings) in
                    
                    if settings.authorizationStatus == .authorized{
                        // Notifications are allowed
                        print("enabled notification setting")
                        if let handler = onCompletion{
                            handler(true)
                        }
                        
                    }else if settings.authorizationStatus == .denied {
                        //
                        print("setting has been disabled")
                        async {
                            guard let controller  = currentController else{return}
                            controller.showNotificationAlert()
                        }
                        if let handler = onCompletion{
                            handler(false)
                        }
                    }else if settings.authorizationStatus == .notDetermined {
                        //  notDetermined
                        print("something vital went wrong here")
                        async {
                            guard let controller  = currentController else{return}
                            controller.showNotificationAlert()
                        }
                        if let handler = onCompletion{
                            handler(false)
                        }
                        
                    }
                    
                }
            }
            
        }
    }
    fileprivate var isNotificationEnabled:Bool{
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    //MARK:registerApns
    func registerApns(application:UIApplication)
    {
        
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            let current = UNUserNotificationCenter.current()
            current.delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            current.requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        //
        // Print full message.
        print(userInfo)
        
    }
    
    //MARK: Notification Methods-
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Envoi le token vers votre serveur.
        print("\n\n /**** TOKEN DATA ***/ \(deviceToken) \n\n")
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        UserDefaults.standard.set(deviceTokenString, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        
        print(getDeviceToken())
        print("\n\n /**** TOKEN STRING ***/ \(deviceTokenString) \n\n")
        
        
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
    func getDeviceToken() -> String
    {
        if let deviceToken =   UserDefaults.standard.object(forKey: "deviceToken")  as? String
        {
            return deviceToken
        }
        return ""
    }
}
extension AppDelegate:UNUserNotificationCenterDelegate{
    
    
    //Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("User Info : %@",userInfo)
        // create a sound ID, in this case its the tweet sound.
        if UIApplication.shared.applicationState == .active {
            print("%@", userInfo)
            let showAction = self.didReceiveRemoteNotification(userAction: false, didReceive: userInfo)
            if showAction == true {
                completionHandler([.alert, .badge, .sound])
            }else{
                // completionHandler([.badge, .sound])
            }
        }else{
            //completionHandler([.alert, .badge, .sound])
        }
        
        
    }
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NSLog("User Info : %@",userInfo)
        // Print full message.
        print(userInfo)
        
        _ =  self.didReceiveRemoteNotification(userAction: true,didReceive: userInfo)
        completionHandler()
    }
    //MARK: -didReceiveRemoteNotification-
    fileprivate func didReceiveRemoteNotification(userAction:Bool = true,didReceive userInfo: [AnyHashable : Any])->Bool    {
        
        guard let apnsResponse  = userInfo["aps"] as? [String: AnyObject] else { return false}
        
        if isLogin{
            
            let objNotiVM = WCNotificationViewModel(parse: apnsResponse)
           // UIApplication.shared.applicationIconBadgeNumber = objNotiVM.badge
            return manage(notiResponse: objNotiVM, userAction: userAction)
        }else{
            return false
        }
        
    }
    fileprivate func manage(notiResponse objNotiVM:WCNotificationViewModel,userAction:Bool)->Bool{
        guard let notificationController = rootController as? UINavigationController , let visibleViewController = notificationController.visibleViewController else { return false }
        if visibleViewController.isKind(of: WCVideoChatVC.self)
        {
            //same Controller
//            if let object  = objNotiVM.objNotification
//            {
//                if object.callStatus == "disconnected"
//                {
//                    let videoChatController = WCVideoChatVC.instance(from: .Main)
//                    videoChatController.callDisconnect()
////                    let dashboardController  = UINavigationController.instance(from: .Main, withIdentifier: StoryBoardIdentity.kMessagesListNavigationVC)
////                    dashboardController.popToViewController(dashboardController, animated: true)
//                }
//            }
            return false
        }
        else{
            if let object  = objNotiVM.objNotification
            {
                if object.callStatus == "connected"
                {
                let videoChatController = WCVideoChatVC.instance(from: .Main)
                videoChatController.readerViewModel = objNotiVM.readerViewModel
                videoChatController.videoChatViewModel.setNotificationData(obj: object)
                videoChatController.callerType = objNotiVM.isOwner == true ?  .sender : .receiver
                videoChatController.isNotifcation = true
                    if object.callType == "audio"
                    {
                        videoChatController.callType = "audio"
                    }else{
                        videoChatController.callType = "video"
                    }
                    
                visibleViewController.navigationController?.pushViewController(videoChatController, animated: true)
                }
                else{
                    
//                    let videoChatController = WCVideoChatVC.instance(from: .Main)
//                    videoChatController.callDisconnect()
                }
            }
        }
        
        return false
        
    }
}

extension AppDelegate{
    func openSettings(){
        let shared = UIApplication.shared
        let url = URL(string: UIApplication.openSettingsURLString)!
        if #available(iOS 10.0, *) {
            shared.open(url)
            
        } else {
            shared.openURL(url)
        }
    }
    
    func setupLogin(){
        let loginNavigation =  UINavigationController.instance(from: .Main, withIdentifier: StoryBoardIdentity.KLoginNavigationVC)
        self.window?.rootViewController = loginNavigation
    }
    func setupDashBooardSubscriber(){
        let dashboardController  = UINavigationController.instance(from: .Main, withIdentifier: StoryBoardIdentity.kCategoryNavigationVC)
        self.window?.rootViewController = dashboardController
    }
    func setupDashBooardPsychic(){
        let dashboardController  = UINavigationController.instance(from: .Main, withIdentifier: StoryBoardIdentity.kMessagesListNavigationVC)
        self.window?.rootViewController = dashboardController
    }
    
//    func showMainController()
//    {
//        setupDashBooardPsychic()
//        //        if isLogin
//        //        {
//        //            setupDashBooard()
//        //        }
//        //        else{
//        //            setupLogin()
//        //        }
//    }
    
}

extension UIApplication {
    var statusBarView : UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

