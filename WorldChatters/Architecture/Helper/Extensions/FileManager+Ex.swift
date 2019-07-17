//
//  FileManager+Ex.swift
//  WorldChatters
//
//  Created by Jitendra Kumar on 20/05/19.
//  Copyright © 2019 Jitendra Kumar. All rights reserved.
//

import Foundation
extension FileManager{
    typealias FileManagerResult = (destinationURL:URL? , isfileExists:Bool , filemanager:FileManager)
    //MARK: - getfileFromDirectory-
    fileprivate static var documentDirectoryPaths :[String]{
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        return paths
    }
    static func getlocalfile( filename:String)->FileManagerResult{
        
        let filemanager =  self.default
        let paths       = documentDirectoryPaths
        if let dirPath = paths.first {
            let fileurl =  URL(fileURLWithPath: dirPath).appendingPathComponent("\(filename)")
            if filemanager.fileExists(atPath: fileurl.path) {
                return (fileurl,true,filemanager)
                
            }else{
                return(nil,false,filemanager)
            }
        }else{
            return(nil,false,filemanager)
        }
        
    }
    //MARK: - deletefileFromDirectory-
    static func deletelocalfile( filename:String, OnCompletion:(_ success:Bool)->Void){
        let result = self.getlocalfile(filename: filename)
        let isfileExists = result.isfileExists
        let destinationURL = result.destinationURL
        let filemanager = result.filemanager
        if isfileExists == true , let url  = destinationURL {
            do{
                try filemanager.removeItem(at: url)
                OnCompletion(true)
            }catch {
                OnCompletion(false)
            }
        }else{
            OnCompletion(false)
        }
        
        
    }
    
}
