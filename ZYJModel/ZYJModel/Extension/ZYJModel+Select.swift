//
//  ZYJModel+Select.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/19.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

extension ZYJModel {
    
    /// 主查语句
    static func select(wheres: String?,groupBy: String? = nil, orderBy : String? = nil, limit: String? = nil, results: (results: NSArray)->()) -> Void {
        
        
            // 主要的数组
            let mutArr = NSMutableArray()
        
        
            if !self.checkTableExistes() {
                HHLog("错误：没有对应的表 \(self)")
            }
            
            var sql = "SELECT * FROM \(self)"
            // 查询条件
            let whereStr = wheres == nil ? "" : " WHERE \(wheres!)"
            
            // 分组
            let groupStr = groupBy == nil ? " GROUP BY zyj_hostId" : " GROUP BY zyj_hostId,\(groupBy!)"
            
            // 排序
            let orderStr = orderBy == nil ? "" : " ORDER BY \(orderBy!)"
            
            // 多少个
            let limitStr = limit == nil ? "" : " LIMIT \(limit!)"
            
            sql.append("\(whereStr)\(groupStr)\(orderStr)\(limitStr)")
            
            
            
            let fieldsArr = NSMutableArray()
            
            
            
            ZYJFMDB.executeQuery(sql: sql) { (set) in
                
                while set.next() {
                    let model = self.init()
                    // 获取数据
                    model.enumratePer(block: { (ivar) in
                        // 是基础属性的时候
                        if ivar.ivarSqlType != ZYJSqlType.EmptyString {
                            
                            let value = set.string(forColumn: ivar.ivarName)
                            model.setValue(value, forKey: ivar.ivarName)
                            
                            if ivar.ivarSqlType == ZYJSqlType.ARR_TYPE {
                                let dict = model.propertyForArray()?.value(forKey: ivar.ivarName)
                                if !NSObject.isBaseTypeInNSArray(dict) {
                                    fieldsArr.add(ivar);
                                }
                                
                            }
                        } else {
                            // 是 Model 的时候
                            
                            if let value = set.string(forColumn: ivar.ivarName) {
                                ivar.ivarCode = value
                                if !fieldsArr.contains(ivar) {
                                    fieldsArr.add(ivar)
                                }
                            }
                        }
                    })
                    mutArr.add(model)
                }
                
            }
            for index in 0..<mutArr.count {
                if let swiftModel = mutArr[index] as? ZYJModel {
                
                    for idx in 0..<fieldsArr.count {
                        if let ivar1 = fieldsArr[idx] as? ZYJIvar {
                                                        
                            if ivar1.ivarSqlType == ZYJSqlType.EmptyString {
                                
                                let whereSql = "zyj_superName = '\(swiftModel.classForCoder)' AND zyj_superHostId = \(swiftModel.zyj_hostId) AND zyj_superPerNmae = '\(ivar1.ivarName)'"
                                
                                let bunle = Bundle.main().objectForInfoDictionaryKey("CFBundleName")
                                // 得到类
                                if let valueClass1 = NSClassFromString("\(bunle as! String).\(ivar1.ivarCode)") {
                                    
                                    let zyjm = valueClass1 as! ZYJModel.Type
                                    
                                    zyjm.select(wheres: whereSql, groupBy: nil, orderBy: nil, limit: "1", results: { (results) in
                                        if results.count > 0 {
                                            swiftModel.setValue(results[0], forKey: ivar1.ivarName)
                                        }
                                    })
                                }
                            } else if ivar1.ivarSqlType == ZYJSqlType.ARR_TYPE {
                                
                                let dict = swiftModel.propertyForArray()?.value(forKey: ivar1.ivarName);
                                
                                if !NSObject.isBaseTypeInNSArray(dict) {
                                    // swift 模型数组
                                    let sqlWhere = "zyj_superName = '\(swiftModel.classForCoder)' AND zyj_superHostId = \(swiftModel.zyj_hostId) AND zyj_superPerNmae = '\(ivar1.ivarName)'"
                                    
                                    if let cls = dict as? ZYJModel.Type {
                                        cls.select(wheres: sqlWhere, results: { (results) in
                                            if results.count > 0 {
                                                swiftModel.setValue(results, forKey: ivar1.ivarName);
                                            } 
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
            results(results: mutArr)
        }
    
    static func find(hostId: Int, result: (result:ZYJModel?) -> Void) {
    
        self.select(wheres: "zyj_hostId = \(hostId)") { (results) in
            
            if results.count > 0 {
                
                result(result: results[0] as? ZYJModel);
                
            }
            
        }
    }
        
}
