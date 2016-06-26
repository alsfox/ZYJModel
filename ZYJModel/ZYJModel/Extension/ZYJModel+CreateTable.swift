//
//  ZYJModel+CreateTable.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/18.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

extension ZYJModel {
    /// 
    static func tableCreate() {
        
        let modelName = "\(self)"
        
        
        let sql = NSMutableString()
        
        sql.append("CREATE TABLE IF NOT EXISTS \(modelName) (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL DEFAULT 0,")// id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL DEFAULT 0,
        let mutArr = NSMutableArray()
        
        self.init().enumratePer { (ivar) in
            
            if !(ivar.ivarSqlType == ZYJSqlType.EmptyString) {
                sql.append("\(ivar.ivarName) \(ivar.ivarSqlType.rawValue),")
                
                
                
            } else {
                sql.append("\(ivar.ivarName) TEXT  DEFAULT '',")
            }
            
            mutArr.add(ivar)
        }
        var subSql = sql.substring(to: sql.length - 1)
        
        subSql.append(");");
        
        
        if ZYJFMDB.executeUpdate(subSql) {
            
        } else {
            
        }
        
        self.fieldsCheck(modelName: modelName, ivars: mutArr)
    }
    /// 字段检查
    static func fieldsCheck(modelName: String, ivars: NSArray) {
        // 字段数组
        let columns = ZYJFMDB.executeQueryColumns(table: modelName);
        
        columns.remove("id")
        
        if columns.count >= ivars.count {
            return;
        }
        
        for item in 0..<ivars.count {
            let ivar: ZYJIvar = ivars[item] as! ZYJIvar
            
            if columns.contains(ivar.ivarName) {
                continue
            }
            
            let sql_addM = "ALTER TABLE '\(modelName)' ADD COLUMN '\(ivar.ivarName)' \(ivar.ivarSqlType.rawValue)"
            
            let addRes = ZYJFMDB.executeUpdate(sql_addM)
            
            if addRes {
                HHLog("已实时添加字段: \(ivar.ivarName) ")
            } else {
                HHLog("添加字段失败")
            }
        }
    }
    func zyj_modelKeyValue(ivar: ZYJIvar) -> (nsme: String, value: AnyObject, arrValue: NSArray?) {
        
        var name = ""
        
        var valueArr : NSArray?
        
        
        // 取出 Model 里的数据
        var ivarValue = self.value(forKey: ivar.ivarName);
        
        /// 不是数组类型的时候
        if !(ivar.ivarSqlType == ZYJSqlType.EmptyString) {
            name = "'\(ivar.ivarName)'"
            
            // 判断是不是 字符
            if ivar.isString {
                
                if let value1 = ivarValue as? String {
                    ivarValue = "'\(value1)'"
                } else {
                    ivarValue = "''"
                }
            } else if ivar.isData {
                if ivarValue != nil {
                    
                    let dataStr = (ivarValue as! NSData).base64EncodedString(NSData.Base64EncodingOptions.encoding64CharacterLineLength)
                    
                    ivarValue = "'\(dataStr)'"
                } else {
                    ivarValue = "''"
                }
            } else if ivar.isArr {
                
                let dict = self.propertyForArray()?.object(forKey: ivar.ivarName)
                
                
              
                if NSObject.isBaseTypeInNSArray(dict) {
                    
                    if let va = (ivarValue as? NSArray)?.toString() {
                        ivarValue = "'\(va)'";
                    } else {
                        ivarValue = "''"
                    }
                } else {
                    // ZYJModel 数组
                    if let arrVaas = ivarValue as? NSArray {
                        valueArr = arrVaas;
                    }
                    
                }
            }
            
        } else {
            
            name = "'\(ivar.ivarName)'";
            
            var typeStr = "\(ivar.ivarType!)"
            
            typeStr = typeStr.replacingOccurrences(of: "Optional<", with: "")
            typeStr = typeStr.replacingOccurrences(of: ">", with: "")
            
            ivarValue = "'\(typeStr)'"
            
        }
        
        
        return (name, ivarValue!,valueArr)
    }
    /// 得到类的 names 和 values 用于 数据库操作
    func zyj_modelSqlNameAndValue(resBlock: (res: Bool) -> ()) -> (names:String, values:String) {
        var names = String()
        var values = String()
        
        
        self.enumratePer { (ivar) in
            // 取出 Model 里的数据
            var ivarValue = self.value(forKey: ivar.ivarName);
            
            /// 不是数组类型的时候
            if !(ivar.ivarSqlType == ZYJSqlType.EmptyString) {
                names.append("'\(ivar.ivarName)',");
                
                // 判断是不是 字符
                if ivar.isString {
                    
                    if let value1 = ivarValue as? String {
                        ivarValue = "'\(value1)'"
                    } else {
                        ivarValue = "''"
                    }
                } else if ivar.isData {
                    if ivarValue != nil {
                        
                        let dataStr = (ivarValue as! NSData).base64EncodedString(NSData.Base64EncodingOptions.encoding64CharacterLineLength)
                        
                        ivarValue = "'\(dataStr)'"
                    } else {
                        ivarValue = "''"
                    }
                } else if ivar.isArr {
                    
                    let dict = self.propertyForArray()?.object(forKey: ivar.ivarName)
                    
                    
                    HHLog("\(ivar.ivarName)")
                    if NSObject.isBaseTypeInNSArray(dict) {
                        
                        if let va = (ivarValue as? NSArray)?.toString() {
                            ivarValue = "'\(va)'";
                        } else {
                            ivarValue = "''"
                        }
                        
                    } else {
                        
                        let modelArr = self.value(forKey: ivar.ivarName);
                        
                        if let letArr = modelArr as? NSArray {
                            letArr.zyj_inserts(superId: self.zyj_replaceHostId(), superProName: ivar.ivarName, superName: "\(self.classForCoder)", block: {
                                resBlock(res: true)
                            })
                            
                        }
                        ivarValue = "''"
                    }
                    
                }
                
                if let valLet = ivarValue {
                    
                    values.append("\(valLet),")
                }
                
                
            } else {
                
                if ivar.ivarName == "thereModel" {
                    
                }
                names.append("'\(ivar.ivarName)',");
                                
                var typeStr = "\(ivar.ivarType!)"
                
                typeStr = typeStr.replacingOccurrences(of: "Optional<", with: "")
                typeStr = typeStr.replacingOccurrences(of: ">", with: "")
                
                values.append("'\(typeStr)',")
                
                if ivarValue != nil {
                    let valueModel = ivarValue as! ZYJModel
                    valueModel.setValue("\(self.classForCoder)", forKey: superName)
                    valueModel.setValue(self.zyj_replaceHostId(), forKey: superHostId)
                    valueModel.setValue(ivar.ivarName, forKey: superPerNmae);
                    
                    valueModel.zyj_insert(resBlock: { (res) in
                        
                    })
                    
                }
                
            }
        }
        let nameSub = (names as NSString).substring(to: (names as NSString).length - 1);
        let valuesSub = (values as NSString).substring(to: (values as NSString).length - 1);
        return (nameSub, valuesSub)
    }
    
    
        
    

}


