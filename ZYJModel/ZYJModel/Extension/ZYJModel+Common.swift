//
//  ZYJModel+Common.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/15.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

func HHLog<T>(_ message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
        let str : String = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")//pathComponents.last.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("\(str)[\(lineNumber)]:\(message)")
    #endif
}


extension NSObject {
    
        
    
    class func isBaseTypeInNSArray (_ anyObject: AnyObject?) -> Bool {
        
        if anyObject is NSString.Type {
            HHLog("NSString")
        } else if anyObject is NSObject.Type{
            return false
        } else if anyObject is  AnyObject.Type {
            return false
        }
        
        if anyObject is NSString.Type || anyObject is String.Type || anyObject is NSString?.Type || anyObject is String?.Type{
            return true
        }
        
        if anyObject is NSData.Type || anyObject is NSData?.Type {
            return true
        }
        
        if ((anyObject?.isEqual(to: "NSString")) != nil) {
            return true
        }
        
        if ((anyObject?.isEqual(to: "NSData")) != nil) {
            return true;
        }
        
        return false
    }
    
    
}
