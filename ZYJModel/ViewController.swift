//
//  ViewController.swift
//  ZYJModel
//
//  Created by 张亚举 on 16/6/14.
//  Copyright © 2016年 张亚举. All rights reserved.
//

import UIKit

struct ZYJModelStruct {
    
}

class ViewController: UIViewController {

    let name = "张亚举"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let dfk = TestModel()
        
        dfk.zyj_hostId = 1
        
        let twoModel = TwoModel()
        let twoModel1 = TwoModel()
        let twoModel2 = TwoModel()
        let twoModel3 = TwoModel()
        twoModel.zyj_hostId = 1;
        
        twoModel3.zyj_hostId = 3;
        twoModel2.zyj_hostId = 2;
        twoModel1.zyj_hostId = 4;
        
        dfk.twoModel = twoModel
        
        dfk.modelArr = [twoModel1,  twoModel2, twoModel3];
        
        dfk.arr = ["sdfsd",
                   
                   "dfsf"] 
        
        
        
        dfk.zyj_insert { (res) in
            print("\(res)")
        }
        
        TestModel.zyj_select(wheres: nil) { (results) in
            
        }
        
        
        dfk.name = "李虹晓"
        
        
        dfk.twoModel?.name = "李虹晓1"
        
        if dfk.modelArr != nil {
            for model in dfk.modelArr! {
                if let m1 = model as? TwoModel {
                    m1.name = "李虹晓1"
                }
            }
        }

        
        dfk.zyj_update { (res) in
            
            HHLog("----");
            
        }
        
        
        let save = TestModel()
        
        save.zyj_hostId = 1;
        
        save.save { (res) in
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

