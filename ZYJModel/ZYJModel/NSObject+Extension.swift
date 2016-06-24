//
//  NSObject+Extension.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/14.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit





extension NSObject {
    
    func enumratePer(block: (ivar: ZYJIvar)->()) {
        let mirror = Mirror(reflecting: self);
        
        for (label, value) in mirror.children {
            
            let ivar = ZYJIvar()
            
            ivar.ivarName = label!
            ivar.ivarType = value.dynamicType
            ivar.ivarValue = value as? NSObject
            
            block(ivar: ivar)
        }
        // 父类 : ZYJModel
        if let superMirror = mirror.superclassMirror {
            for (label, value) in superMirror.children {
                
                let ivar = ZYJIvar()
                
                ivar.ivarName = label!
                ivar.ivarType = value.dynamicType
                
                block(ivar: ivar)
            }
        }
    }
    /*
    static func enumratePer(block: (ivar: ZYJIvar)->()) {
        let mirror = Mirror(reflecting: self.init());
        
        for (label, value) in mirror.children {
            
            let ivar = ZYJIvar()
            
            ivar.ivarName = label!
            ivar.ivarType = value.dynamicType
            ivar.ivarValue = value as? NSObject
            
            block(ivar: ivar)
        }
        // 父类 : ZYJModel
        if let superMirror = mirror.superclassMirror {
            for (label, value) in superMirror.children {
                
               
                let ivar = ZYJIvar()
                
                ivar.ivarName = label!
                ivar.ivarType = value.dynamicType
                ivar.ivarValue = value as? NSObject
                
                block(ivar: ivar)
            }
        }
    }
    */
    /// 查检有没有表
    class func checkTableExistes () -> Bool {
        
        let alias = "tableCount"
        
        let sql = "SELECT COUNT(*) \(alias) FROM sqlite_master WHERE type='table' AND name='\(self)';"
        
        var res = false
        
        ZYJFMDB.executeQuery(sql: sql) { (set) in
            while set.next() {
                let count =  set.string(forColumn: alias) as NSString
                
                if count.integerValue == 1 {
                    res = true
                } else {
                    res = false
                }
                
            }
        }
        return res;
        
    }
    
}
