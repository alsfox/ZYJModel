//
//  ZYJModel+Insert.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/15.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit



extension ZYJModel {
    /// 保存数据
    internal func zyj_insert(resBlock: (res: Bool) -> ()) -> Void {
        
        if !self.checkTableExistes() {
            HHLog("错误：模型:\(self) 没有对应的数据表！")
            resBlock(res: false)
        }
        
        if !Thread.isMainThread() {
            HHLog("错误：为了数据安全，数据插入API必须在主线程中执行！")
            resBlock(res: false)
        }
        
        if self.zyj_replaceHostId() == 0 {
            HHLog("警告：无 zyj_hostId的数据插入")
        }
        let modelSql = self.zyj_modelSqlNameAndValue { (res) in
            
        }
        
        let sql = "INSERT INTO \(self.classForCoder) (\(modelSql.names)) VALUES (\(modelSql.values));"
        
        HHLog( "\(sql)")
                
        let insertRes = ZYJFMDB.executeUpdate(sql)
        
        resBlock(res: insertRes);
        
        if insertRes {
            
            HHLog("插入成功");
        }
    }
    /// 查检有没有表
    func checkTableExistes () -> Bool {
        
        let alias = "tableCount"
        
        let sql = "SELECT COUNT(*) \(alias) FROM sqlite_master WHERE type='table' AND name='\(self.classForCoder)';"
        
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

