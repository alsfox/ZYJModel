//
//  ZYJModel+Update.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/24.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

extension ZYJModel {
    /// 更新 Model
    internal func zyj_update(resBlock: (res: Bool) -> ()) {
        
        self.dynamicType.zyj_find(hostId: self.zyj_replaceHostId()) { (result) in
            
            if result != nil {
                
                
                let modelSql = self.zyj_updateKeyValue()
                
                let superHostId = self.zyj_superHostId != 0 ? "AND zyj_superHostId = \(self.zyj_superHostId) " : ""
                
                let superName = self.zyj_superName != nil ? "AND zyj_superName = '\(self.zyj_superName!)' " : ""
                
                let superProName = self.zyj_superPerNmae != nil ? "AND zyj_superPerNmae = '\(self.zyj_superPerNmae!)'" : ""
                
                let sql = "UPDATE \(self.classForCoder) SET \(modelSql)  WHERE zyj_hostId = \(self.zyj_replaceHostId()) \(superHostId)  \(superName) \(superProName) ;"
                
                
                self.dynamicType.zyj_select(wheres: nil, results: { (results) in
                    HHLog("\(results)")
                })
                
                HHLog("\(sql)");
                let insertRes = ZYJFMDB.executeUpdate(sql)
                
                resBlock(res:insertRes);
            }else {
                
                HHLog("数据库没有此条数据")
                
            }
        }
    }
    
    /// 单个数据更新
    func zyj_updateKeyValue() -> String {
        var names = String()
        
        self.enumratePer { (ivar) in
            var proprety = self.zyj_modelKeyValue(ivar: ivar as ZYJIvar)
            
            
            if let valueArr = proprety.arrValue {
                
                valueArr.zyj_deleteAction(superId: self.zyj_replaceHostId(), superProName: "\(self.classForCoder)", superName: ivar.ivarName, deleteBlock: {
                    
                })
                valueArr.zyj_inserts(superId: self.zyj_replaceHostId(), superProName: "\(self.classForCoder)", superName: ivar.ivarName, block: { 
                    
                })
                
                proprety.value = ""
                
                
            }
            
            
            
            names.append(" \(proprety.nsme) = \(proprety.value),")
        }
        
        return (names as NSString).substring(to: (names as NSString).length - 1);
    }

    
}
