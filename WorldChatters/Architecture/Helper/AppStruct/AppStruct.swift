//
//  AppUtility.swift
//  B2BApp
//
//  Created by Jitendra Kumar on 06/12/17.
//  Copyright © 2017 Mobilyte. All rights reserved.
//

import UIKit


struct EmojiFont {
    static let rightArraow = "→"
    static let leftArrow = "←"
    static let bulletIcon = "•"
    static let radioselect = "◉"
    static let rediounSelect = "◎"
    static let downTrangle = "▾"
    static let rightTrangle = "‣"
    static let leftTrangle = "◀︎"
    static let sadEmoji = "☹"
    static let crossEmoji = "×"
}

struct ScreenSize
{
    static let kScreenWidth         = UIScreen.main.bounds.size.width
    static let kScreenHeight        = UIScreen.main.bounds.size.height
    static let kScreenMaxLenght     = max(ScreenSize.kScreenWidth, ScreenSize.kScreenHeight)
    static let kScreenMinLenght     = min(ScreenSize.kScreenWidth, ScreenSize.kScreenHeight)
    
    // Native bounds of the physical screen in pixels
    static var kNativeBounds:CGRect  {return UIScreen.main.nativeBounds}
    static var kNativeHeight:CGFloat {return kNativeBounds.height}
    static var kNativeWidth:CGFloat  {return kNativeBounds.width}
}

struct DeviceType
{
    
    static let IS_IPHONE_4_OR_LESS                      = Platform.isPhone && ScreenSize.kScreenMaxLenght < 568.0
    static let IS_IPHONE_5_OR_5s_OR_5c_OR_SE            = Platform.isPhone && ScreenSize.kScreenMaxLenght == 568.0
    static let IS_IPHONE_6_OR_6s_OR_7_OR_8              = Platform.isPhone && ScreenSize.kScreenMaxLenght == 667.0
    static let IS_IPHONE_6P_OR_6sP_OR_7P_OR_8P          = Platform.isPhone && ScreenSize.kScreenMaxLenght == 736.0
    static let IS_IPHONE_X_OR_Xs                        = Platform.isPhone && ScreenSize.kScreenMaxLenght == 812.0
    static let IS_IPHONE_XR_OR_XsMax                    = Platform.isPhone && ScreenSize.kScreenMaxLenght == 896.0

    
    static let IS_IPAD                                  = Platform.isPad && ScreenSize.kScreenMaxLenght == 1024.0
    static let IS_IPAD_PRO                              = Platform.isPad && ScreenSize.kScreenMaxLenght == 1366.0
    
    
    
}

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
    static var isPhone:Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? true :false
    }
    static var isPad:Bool {
        return UIDevice.current.userInterfaceIdiom == .pad ? true :false
    }
}




struct SGStoryboard {
    static let mainStoryboard:UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: nil)
    }()
    static let homeStoryboard:UIStoryboard = {
        return UIStoryboard(name: "Home", bundle: nil)
    }()
}



struct SegueIdentity {
    
    
    static let kLoginSegue                    = "LoginSegue"
    static let kSignUpSegue                   = "SignUpSegue"
    static let kConfirmSignUpSegue            = "ConfirmSignUpSegue"
    static let kForgotPasswordSegue           = "ForgotPasswordSegue"
    static let kConfirmForgotPasswordSegue    = "ConfirmForgotPasswordSegue"
    static let kCategorySegue                 = "CategorySegue"
    static let kReaderSegue                   = "ReaderSegue"
    static let kReaderProfileSegue            = "ReaderProfileSegue"
    static let kVoiceCallingSegue             = "VoiceCallingSegue"
    static let kCallActivitySegue             = "CallActivitySegue"
    
}

struct StoryBoardIdentity {
    
    static let KLoginVC                 = "LoginController"
    static let KLoginNavigationVC       = "LoginNavigationVC"
    static let kForgotVC                = "ForgotVC"
    static let kCategoryVC              = "CategoryVC"
    static let kCategoryNavigationVC    = "CategoryNavigationVC"
  
}


struct TBCellIdentity {
    
    static let kCategoryCell            = "CategoryCell"
    static let kLoadMoreCell            = "LoadMoreCell"
    static let kReaderCell              = "ReaderCell"
    static let kCallActivityCell        = "CallActivityCell"
    static let kBlockForPrivacyCell     = "BlockForPrivacyCell"
    static let kActivityCell            = "ActivityCell"
    static let kSenderCell              = "SenderCell"
    static let kReceiverCell            = "ReceiverCell"
   
}


struct FieldValidation {
    static let kFirstNameEmpty       = "Please enter your first name."
    static let kLastNameEmpty        = "Please enter your last name."
    static let kEmailEmpty           = "Please enter your username or email address."
    static let kValidEmail           = "Please enter a valid email address."
    static let kValidPhoneNumber     = "Please enter a valid phone number."
    static let kcountryCode          = "Please select country code."
    static let kPasswordEmpty        = "Please enter password."
    static let kAlreadyUsedPassword  = "You have already used this password, please try another password."
    static let kCurrentPasswordEmpty = "Please enter current password."
    static let kPassMinLimit         = "Your password should be minimum of 6 characters."
    static let kValidPass            =  "Password must be at least 6 characters long."
    static let kConfirmPassEmpty     = "Please confirm password."
    static let kPassMissMatch        = "Passwords don't match."
    static let kAuthSessionExpire    = "Your session expired, Please try login again."
    static let kOTPCodeEmpty         = "Please enter verification code."
    static let kValidOTPCode         = "Verification code should contain only numbers."
    static let kSingUpSuccess        =  "\(kAppTitle) user account created successfully, a verification code has been sent your email address."
    static let kUserNotExist            = "User does not exist. Please create new account."
    static let kAuthorizationcodeEmpty = "Please enter the authentication code you received by email"
    static let kResetPasssword       = "Your password has been reset."
    
    
    
}

func secondsToHoursMinutesSeconds (seconds : Int) -> (Hours:Int, Minutes:Int, Seconds:Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

