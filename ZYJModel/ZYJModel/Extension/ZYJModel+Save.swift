//
//  ZYJModel+Save.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/26.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

class ZYJModel_Save: ZYJModel {

}


extension ZYJModel {
    
    
    func save(saveBlock: (res: Bool) -> ()) {
        
        self.dynamicType.zyj_find(hostId: self.zyj_hostId) { (result) in
            if result != nil {
                // 有数据  更新
                result?.zyj_update(resBlock: { (res) in
                    saveBlock(res: res)
                })
                
            } else {
                // 没有数据 插入
                self.zyj_insert(resBlock: { (res) in
                    saveBlock(res: res);
                })
            }
        }
        
    }
    
}
