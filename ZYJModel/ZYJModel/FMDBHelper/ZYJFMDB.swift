//
//  ZYJFMDB.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/14.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit


let sharedFMDB = ZYJFMDB();

class ZYJFMDB: NSObject {
    
    var queue: FMDatabaseQueue?
    
    static override func  initialize() {
        
        let docsdir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        
        
        let infoDict = Bundle.main().infoDictionary
        
        let bundleNmae = infoDict?[kCFBundleNameKey as String] as! String
        let sqlStr = "\(docsdir!)/\(bundleNmae).sql"
        HHLog("\(sqlStr)");
        //创建队列
        let queue = FMDatabaseQueue(path: sqlStr)
        
        
        sharedFMDB.queue = queue;
    }
    
    /// 执行一个 更新语句
    internal static func executeUpdate(_ sql: String) -> Bool {
        var updateRes = false
        
        sharedFMDB.queue?.inDatabase({ (db) in
            let args : CVaListPointer = getVaList([])
            updateRes = (db?.executeUpdate(sql, withVAList: args))!
        })
        return updateRes
    }
    
    /// 一个查询语句
    static func executeQuery(sql: String, queryResBlock: (set: FMResultSet) -> ()){
        sharedFMDB.queue?.inDatabase({ (db) in
            let args : CVaListPointer = getVaList([])
            let resultSet = [db?.executeQuery(sql, withVAList: args)]
            
            queryResBlock(set: resultSet[0]!)
        })
    }
    
    /// 查询出指定表的列
    static func executeQueryColumns(table: String) -> NSMutableArray {
        let columnsM = NSMutableArray()
        
        let sql = "PRAGMA table_info (\(table));"
        
        self.executeQuery(sql: sql) { (set) in
            
            while set.next() {
                let column = set.string(forColumn: "name")!
                columnsM.add(column)
            }
            
        }
        
        return columnsM.mutableCopy() as! NSMutableArray
    }
    
}
