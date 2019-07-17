//
//  AppEnums.swift
//  B2BApp
//
//  Created by Jitendra Kumar on 15/12/17.
//  Copyright © 2017 Mobilyte. All rights reserved.
//

import Foundation
import UIKit
enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}


enum AppStoryboard:String {
    case Main
    var instance:UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    func viewController<T:UIViewController>(viewController classObject :T.Type)->T{
        let storyboardId = classObject.storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }
    func viewController<T:UIViewController>(withIdentifier identifier :String)->T{
        return instance.instantiateViewController(withIdentifier: identifier) as! T
    }
    func initalViewController<T:UIViewController>()->T?{
        return instance.instantiateInitialViewController() as? T
    }
}
enum HTTPStatusCodes: Int {
    // 100 Informational
    case Continue = 100
    case SwitchingProtocols
    case Processing
    // 200 Success
    case OK = 200
    case Created
    case Accepted
    case NonAuthoritativeInformation
    case NoContent
    case ResetContent
    case PartialContent
    case MultiStatus
    case AlreadyReported
    case IMUsed = 226
    
    // 300 Redirection
    case MultipleChoices = 300
    case MovedPermanently
    case Found
    case SeeOther
    case NotModified
    case UseProxy
    case SwitchProxy
    case TemporaryRedirect
    case PermanentRedirect
    
    // 400 Client Error
    case BadRequest = 400
    case Unauthorized = 401
    case PaymentRequired = 402
    case Forbidden  = 403
    case NotFound = 404
    case MethodNotAllowed = 405
    case NotAcceptable
    case ProxyAuthenticationRequired
    case RequestTimeout
    case Conflict
    case Gone
    case LengthRequired
    case PreconditionFailed
    case PayloadTooLarge
    case URITooLong
    case UnsupportedMediaType
    case RangeNotSatisfiable
    case ExpectationFailed
    case ImATeapot
    case MisdirectedRequest = 421
    case UnprocessableEntity
    case Locked
    case FailedDependency
    case UpgradeRequired = 426
    case PreconditionRequired = 428
    case TooManyRequests
    case RequestHeaderFieldsTooLarge = 431
    case UnavailableForLegalReasons = 451
    // 500 Server Error
    case InternalServerError = 500
    case NotImplemented
    case BadGateway
    case ServiceUnavailable
    case GatewayTimeout
    case HTTPVersionNotSupported
    case VariantAlsoNegotiates
    case InsufficientStorage
    case LoopDetected
    case NotExtended = 510
    case NetworkAuthenticationRequired
    
    var description:String{
        switch self {
        case .BadRequest:
            return "BadRequest"
        case .Unauthorized:
            return "Unauthorized"
        case .PaymentRequired:
            return "Payment Required"
        case  .Forbidden:
            return "Forbidden Request"
        case .NotFound:
            return "Request NotFound"
        case .MethodNotAllowed:
            return "HTTP Method Not Allowed"
        case .NotAcceptable:
            return "Request Not Acceptable"
        case .ProxyAuthenticationRequired:
            return "Proxy Authentication Required"
        case .RequestTimeout:
            return "Request Timeout"
        case .Conflict:
            return "Conflict"
            
        default:
            return kAppTitle
        }
    }
}

