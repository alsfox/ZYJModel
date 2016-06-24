//
//  ZYJModel.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/14.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

public let YES = true
public let NO = false

public let superName = "zyj_superName"
public let superPerNmae = "zyj_superPerNmae"
public let superHostId = "zyj_superHostId"





class ZYJModel: NSObject {
    /// 类主键
    var zyj_hostId : Int = 0
    /// 所属类的名字
    var zyj_superName : String?
    /// 所属类的 ID
    var zyj_superHostId : Int = 0
    
    /// 所属 父类的 属性
    var zyj_superPerNmae : String?
    
    required override init() {
        super.init()
    }
    
    func propertyForArray() -> NSDictionary? {
        
        return nil
    }
    
    
    
    static override func initialize() {
        
        
        
        self.tableCreate()
    }
    
    
    
    internal func zyj_replaceHostId() -> String? {
        return nil;
    }
}
