//
//  ViewController.swift
//  studentTestSwift
//
//  Created by MACMINI on 16/2/4.
//  Copyright © 2016年 LZJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // 程序会根据frame.height的值设置字体的大小，所以不能为0
        let zjr = ZJRadio.init(frame: CGRectMake(0, 64, 320, 20), arr: ["男性", "女性", "第三人", "亚洲", "非洲", "欧洲", "澳洲"], isAutoHeight: true) { (cur) -> (Void) in
            NSLog("当前点击：%d", cur)
        }
        self.view.addSubview(zjr)
        
        let zjr1 = ZJRadio.init(frame: CGRectMake(0, 200, 320, 20), arr: ["男性", "女性", "第三人", "亚洲", "非洲", "欧洲", "澳洲"], isAutoHeight: false) { (cur) -> (Void) in
            NSLog("当前点击1：%d", cur)
        }
        self.view.addSubview(zjr1)
        // Do any additional setup after loading the view, typically from a nib.
    }
}

