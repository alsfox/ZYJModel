//
//  ZYJIvar.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/14.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit


/// 转换为 Sql 数据库里的 类型
public enum ZYJSqlType: String {
    /// 整数
    case INTEGER_TYPE = "INTEGER  DEFAULT 0"
    
    case INTEGERKEY_TYPE = "INTEGER UNIQUE DEFAULT 0"
    /// 文字
    case TEXT_TYPE = "TEXT  DEFAULT ''"
    /// 小娄
    case REAL_TYPE = "REAL  DEFAULT 0.0"
    
    case ARR_TYPE = "TEXT  DEFAULT  ''"
    
    /// 空字符
    case EmptyString = ""
}



class ZYJIvar: NSObject {
    
    /// 变量名字
    var ivarName : String = ""
    
    var ivarValue: NSObject?
    
    
    /// 变量转换的 Sql 数据库类型
    var ivarSqlType : ZYJSqlType {
        get{
            
            if ivarName == "zyj_hostId" {
                return ZYJSqlType.INTEGERKEY_TYPE
            }
            
            switch ivarType {
                
            case is String?.Type:
                
                return .TEXT_TYPE
                
            case is Int?.Type:
                return .INTEGER_TYPE
                
            case is CGFloat?.Type:
                return .REAL_TYPE
                
            case is NSString?.Type:
                return .TEXT_TYPE
                
            case is Bool?.Type:
                return .INTEGER_TYPE
            case is NSArray?.Type:
                return .ARR_TYPE
            case is NSMutableArray?.Type:
                return .ARR_TYPE
            case is Double?.Type:
                return .REAL_TYPE
                
                
                
                
            case is String.Type:
                
                return .TEXT_TYPE
                
            case is Int.Type:
                return .INTEGER_TYPE
                
                
            case is CGFloat.Type:
                return .REAL_TYPE
                
            case is NSString.Type:
                return .TEXT_TYPE
                
            case is Bool.Type:
                return .INTEGER_TYPE
            case is NSArray.Type:
                return .ARR_TYPE
            case is NSMutableArray.Type:
                return .ARR_TYPE
            case is Double.Type:
                return .REAL_TYPE
                
            
                
            default:
                return .EmptyString
            }
        }
    }
    
    var ivarCode = ""
    
    
    /// 变量类型
    var ivarType : Any.Type!
    
    /// 判断是不是 String
    var isString :  Bool {
        get {
            switch ivarType {
            case is String.Type:
                return true
                
            case is String?.Type:
                return true;
                
            case is NSString.Type:
                return true
                
            case is NSString?.Type:
                return true
            default:
                return false
            }
        }
    }
    
    var isData : Bool {
        get {
            switch ivarType {
            case is NSData.Type:
                return true
                
            case is NSData?.Type:
                return true;
            default:
                return false
            }
        }
    }
    
    var isArr : Bool {
        get {
            switch ivarType {
            case is NSArray.Type:
                return true
            case is NSArray?.Type:
                return true;
            default:
                return false
            }
        }
    }
    
}
