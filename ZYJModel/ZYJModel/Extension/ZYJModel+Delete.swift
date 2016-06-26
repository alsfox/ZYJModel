//
//  ZYJModel+Delete.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/24.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit


extension  ZYJModel {
    
    class func zyj_deleteActon(whereS: String?, resBlock: (res: Bool)->()) -> Void {
        
        if !self.checkTableExistes() {
            
            var sql = "DELETE FROM \(self.classForCoder)"
            
            if whereS != nil {
                sql.append(" WHERE \(whereS)");
            }
            
            
            
            HHLog("\(sql)")
            
        }
        
    }
    
    internal func zyj_delete(resBlock: (res: Bool)->()) -> Void {
        
        if !self.checkTableExistes() {
            
            HHLog("\(self.classForCoder) 表不存在") ;
            
        }
        let sql = "DELETE FROM \(self.classForCoder) WHERE zyj_hostId = \(self.zyj_replaceHostId())"
        
        let dict1 = self.propertyForArray()
        
        
        self.enumratePer { (ivar) in
            let value = self.value(forKey: ivar.ivarName);
            // 是基础属性的时候
            if ivar.ivarSqlType != ZYJSqlType.EmptyString {
                
                if ivar.ivarSqlType == ZYJSqlType.ARR_TYPE {
                    let dict = dict1?.value(forKey: ivar.ivarName)
                    if !NSObject.isBaseTypeInNSArray(dict) {
                        if let modelArr = value as? NSArray {
                            modelArr.zyj_delete(deleteBlock: {
                                
                            })
                        }
                        
                        if let modelMutArr = value as? NSMutableArray {
                            modelMutArr.zyj_delete(deleteBlock: {
                                
                            })
                        }
                    }
                }
            } else {
                if let model1 = value as? ZYJModel {
                    model1.zyj_delete(resBlock: { (res) in
                        
                    })
                }
                
                
            }
           
            
        }
        
        resBlock(res: ZYJFMDB.executeUpdate(sql))
        
        
        
        HHLog("\(sql)")
    }
    
}
