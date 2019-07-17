//
//  SMUtility.swift
//  StableGuard
//
//  Created by Jitendra Kumar on 24/09/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit
import MobileCoreServices
//MARK: - AppUtility -
class SMUtility:NSObject{
    fileprivate var jkHud:JKProgressHUD!
    class var shared:SMUtility{
        struct  Singlton{
            static let instance = SMUtility()
        }
        return Singlton.instance
    }
    fileprivate var isNetworkActivity:Bool = false {
        didSet{
            UIApplication.shared.isNetworkActivityIndicatorVisible = isNetworkActivity
        }
        
    }
    //MARK:- showProgressHud-
    func showHud(inView view:UIView = AppDelegate.shared.window!,message title:String = ""){
        
        self.hideHud()
        self.jkHud = JKProgressHUD.showProgressHud(inView: view, titleLabel: title)
        self.jkHud.setNeedsLayout()
        self.jkHud.lineColor = JKColor.DeepPurple
        
    }
    //MARK:- hideHud-
    func hideHud(){
        if (self.jkHud != nil) {
            self.jkHud.hideHud(animated: true)
        }
        self.showNetIndicator = false
    }
    var showNetIndicator:Bool = false{
        didSet{
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.showNetIndicator
            }
        }
    }


    //MARK:- mimeTypeForPath-
    static func mimeType(forPath filePath:URL)->String{
        var mimeType:String
        let fileExtension:CFString = filePath.pathExtension as CFString
        let UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, nil)
        let str = UTTypeCopyPreferredTagWithClass(UTI!.takeUnretainedValue(), kUTTagClassMIMEType)
        if let value = str {
            mimeType = value.takeUnretainedValue() as String
        }else{
            mimeType = "application/octet-stream"
        }
        return mimeType
    }
    //MARK:- filename-
    static func filename(Prefix:String , fileExtension:String)-> String{
        let dateformatter=DateFormatter()
        dateformatter.dateFormat="MddyyHHmmss"
        let dateInStringFormated=dateformatter.string(from: Date() )
        return "\(Prefix)_\(dateInStringFormated).\(fileExtension)"
    }
    
}
public enum JPEGQuality:Int,CustomStringConvertible {
    case highest
    case high
    case medium
    case low
    case lowest
    public var description: String{
        switch self {
        case .highest:return "highest Quality JPEG Formate data"
        case .high:return "high Quality JPEG Formate data"
        case .medium:return  "medium Quality JPEG Formate data"
        case .low:return  "low Quality JPEG Formate data"
        case .lowest:return "lowest Quality JPEG Formate data"
        }
    }
}
public enum ImageFormate:CustomStringConvertible{
    case png
    case jpeg(quality:JPEGQuality)
    func imageData(image:UIImage)->Data{
        switch self {
        case .jpeg(let quality):
            switch quality{
            case .highest:return image.highestJPEG
            case .high:return image.highJPEG
            case .medium:return image.mediumJPEG
            case .low:return image.lowQualityJPEG
            case .lowest:return image.lowestQualityJPEG
            }
        case .png:
            return image.png
            
        }
    }
    public var description: String{
        switch self {
        case .png:
            return "png"
        default:
            return "jpeg"
        }
    }
    public var mimType:String{
        switch self {
        case .png:
            return "image/png"
        default:
            return "image/jpeg"
        }
    }
    
}

enum DataType {
    case image(image: UIImage, fileName: String?, uploadKey: String, formate:ImageFormate)
    case file(file:Any, uploadKey :String)
}
enum DataFormate{
    case base64(type:DataType)
    case multipart(type:DataType)
    
    var convert:Any{
        switch self {
        case .base64(let type):
            switch type{
            case .image(let  image, let fileName, let uploadKey, let formate):
                return Base64Data(image: image, fileName: fileName, mediaKey: uploadKey, formate: formate)
            case .file(let file, let uploadKey):
                return Base64Data(file: file, mediaKey: uploadKey)
            }
        case .multipart(let type):
            switch type{
            case .image(let  image, let fileName, let uploadKey, let formate):
                return MultipartData(image: image, fileName: fileName, mediaKey: uploadKey, formate: formate)
            case .file(let file, let uploadKey):
                return MultipartData(file: file, mediaKey: uploadKey)
            }
        }
    }
    
    
    
    
}

struct Base64Data {
    var base64String:String!
    var mediaUploadKey:String!
    var fileName:String!
    var pathExtension:String!
    
    init(image:UIImage,fileName:String? = nil,mediaKey uploadKey:String,formate:ImageFormate = .png) {
        
        let data            = formate.imageData(image: image)
        self.base64String   = data.base64EncodedString()
        self.pathExtension  = formate.description
        self.mediaUploadKey = uploadKey
        self.fileName       = fileName ?? SMUtility.filename(Prefix: "image", fileExtension:  self.pathExtension)
    }
    
    init(file:Any,mediaKey uploadKey:String) {
        var imagedata :Data?
        if let filepath = file as? String{
            let url = NSURL.fileURL(withPath: filepath)
            self.pathExtension = url.pathExtension
            self.fileName = url.lastPathComponent
            imagedata = try! Data(contentsOf: url)
        }else if  let fileurl = file as? URL {
            self.pathExtension = fileurl.pathExtension
            self.fileName = fileurl.lastPathComponent
            imagedata = try! Data(contentsOf: fileurl)
            
        }
        guard let data  = imagedata else {return}
        self.mediaUploadKey = uploadKey
        self.base64String = data.base64EncodedString()
        
        
    }
    
}
//MARK:- MultipartData
struct MultipartData{
    var media:Data!
    var mediaUploadKey:String!
    var fileName:String!
    var mimType:String!
    var pathExtension:String!
    init(image:UIImage,fileName:String? = nil,mediaKey uploadKey:String,formate:ImageFormate = .png) {
        
        self.media          = formate.imageData(image: image)
        self.mimType        = formate.mimType
        self.pathExtension  = formate.description
        self.fileName = fileName ?? SMUtility.filename(Prefix: "image", fileExtension:  self.pathExtension)
        self.mediaUploadKey = uploadKey
    }
    init(file:Any,mediaKey uploadKey:String) {
        if let filepath = file as? String{
            let url = NSURL.fileURL(withPath: filepath)
            self.pathExtension = url.pathExtension
            self.fileName = url.lastPathComponent
            self.media = try! Data(contentsOf: url)
            self.mimType = SMUtility.mimeType(forPath:url)
        }else if  let fileurl = file as? URL {
            self.pathExtension = fileurl.pathExtension
            self.fileName = fileurl.lastPathComponent
            self.media = try! Data(contentsOf: fileurl)
            self.mimType = SMUtility.mimeType(forPath:fileurl)
        }
        self.mediaUploadKey = uploadKey
        
    }
    
    
    
}


protocol SMErrorProtocol: Error {
    
    var localizedTitle: String { get }
    var localizedDescription: String { get }
    var code: Int { get }
}
struct SMError: SMErrorProtocol {
    
    var localizedTitle: String
    var localizedDescription: String
    var code: Int
    
    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}
extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
// Helper function inserted by Swift 4.2 migrator.
func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

enum ApiStatus:String {
    case success = "ok"
    case failure = "failed"
    
}
extension JSON{
    
    var responseMsg :String {
        if self["message"].exists(){
            return self["message"].stringValue
        }else if self["successMessage"].exists(){
            return self["successMessage"].stringValue
        } else if self["reason"].exists(){
            return self["reason"].stringValue
        }else{
            return  "no data found."
        }
    }
    var status:String   {
        return self["status"].stringValue.lowercased()
        
    }
    
}
