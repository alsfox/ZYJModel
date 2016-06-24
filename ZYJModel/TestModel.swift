//
//  TestModel.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/15.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

class TestModel: ZYJModel {
    var name = "张亚举"
    var arr = NSArray()
    
    var twoModel : TwoModel?
    
    var thereModel : TwoModel?
    
    var fourModel : TwoModel = TwoModel()
    
    var modelArr : NSArray?
    
    
    
    override func propertyForArray () -> NSDictionary?{
        
        return ["arr" : "NSString",
                "modelArr" : TwoModel.self
        ]
    
    }
    
}

class TwoModel: ZYJModel {
    var name = "张亚举磊"
    
    var tesmo = "需要晨露"
    
    
}
