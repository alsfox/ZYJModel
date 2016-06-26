//
//  NSObject+NSArray.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/15.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

extension NSArray {
    
    func toString() -> String {
        
        var strM = String()
        
        
        var length = 0
        
        self.enumerateObjects(EnumerationOptions.reverse, using: { (obj, idx, stop) in
            
            
            if obj.isKind(of: NSString.self) {
                if length == 0 {
                    length = 1;
                }
                strM.append("\(obj),")// append();
            } else if obj.isKind(of: NSData.self) {
                if length == 0 {
                    length = 12 // "SymbolString"
                    strM.append("\((obj as! NSData).base64EncodedString(NSData.Base64EncodingOptions.encoding64CharacterLineLength))SymbolString")
                }
            }
        })
        let strReslut = strM as NSString
        if strReslut.length > 0 {
            return  strReslut.substring(to: strReslut.length - 1)
        } else {
            return ""
        }
    }
    /// 增加单个 数据
    internal func zyj_inserts(block:()->()) {
        for item in self {
            
            if let model = item as? ZYJModel {
                model.zyj_insert(resBlock: { (res) in
                    
                })
            }
            
        }
        block()
    }
    /// 数组中的增加
    internal func zyj_inserts(superId: Int, superProName: String, superName: String, block: () -> ()) -> Void {
        for item in self {
            
            if let model = item as? ZYJModel {
                
                model.zyj_superName = superName;
                model.zyj_superHostId = superId;
                model.zyj_superPerNmae = superProName
                
                model.zyj_insert(resBlock: { (res) in
                    
                })
            }
            
        }
        block()
    }
    
    /// 数组中的删除
    internal func zyj_deleteAction(superId: Int, superProName: String, superName: String, deleteBlock: ()->()){
        for item in self {
            if let model = item as? ZYJModel {
                
                model.zyj_superName = superName;
                model.zyj_superHostId = superId;
                model.zyj_superPerNmae = superProName
                
                model.zyj_delete(resBlock: { (res) in
                    
                })
            }
        }
        deleteBlock()
    }
    
    /// 删除单个数据
    internal func zyj_delete(deleteBlock: ()->()) {
        for item in self {
            if let model = item as? ZYJModel {
                model.zyj_delete(resBlock: { (res) in
                    
                })
            }
        }
        deleteBlock()
    }
    // 单个数据更新
    internal func zyj_update(updateBlock : () -> ()) {
        for item in self {
            if let model = item as? ZYJModel {
                model.zyj_update(resBlock: { (res) in
                    
                })
            }
        }
    }
    
    /// 数组数据更新
    internal func zyj_updateArrKeyValue(superHostID: Int, superName: String, superProName: String)  {
        for item in self {
            if let model = item as? ZYJModel {
                model.zyj_superHostId = superHostID
                model.zyj_superName = superName
                model.zyj_superPerNmae = superProName
                
                model.zyj_update(resBlock: { (res) in
                    
                })
            }
        }
    }
    
}
