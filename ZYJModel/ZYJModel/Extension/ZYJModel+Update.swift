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
                
                let sql = "UPDATE \(self.classForCoder) SET \(modelSql)  WHERE zyj_hostId = \(self.zyj_replaceHostId());"
                
                let insertRes = ZYJFMDB.executeUpdate(sql)
                
                resBlock(res:insertRes);
                
            }
            
        }
    }
    
    
    
}
