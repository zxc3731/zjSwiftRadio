//
//  ZJRadio.swift
//  studentTestSwift
//
//  Created by MACMINI on 16/2/23.
//  Copyright © 2016年 LZJ. All rights reserved.
//

import UIKit

class ZJRadio: UIView {
    let theArr: [NSString]
    var theFont: UIFont
    var curValue: Int
    var theCB: (cur: Int)->(Void)
    
    private let leftLabelTag = 100
    private let rightButtonTag = 101
    private let space: CGFloat = 5.0
    private let rightAndLeftSpace: CGFloat = 3.0
    /**
     实现单选功能
     
     - parameter frame:        view占的大小, 程序会根据frame.height的值设置字体的大小，所以不能为0
     - parameter arr:          选项属性
     - parameter isAutoHeight: 是否自动调整高度
     - parameter clb:          点击回调参数
     
     - returns: self
     */
    init(frame: CGRect, arr: [NSString], isAutoHeight: Bool = false, clb: (cur: Int)->(Void)) {
        self.theArr = arr
        self.theFont = UIFont.systemFontOfSize(frame.height)
        self.curValue = 0
        self.theCB = clb
        super.init(frame: frame)
        isAutoHeight ? self.markViews_AutoHeight() : self.markViews()
        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     创建view
     */
    func markViews() {
        let subV: NSArray = self.subviews
        subV.enumerateObjectsUsingBlock { (obj: AnyObject, thei: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            obj.removeFromSuperview()
        }
        var curOriginX: CGFloat = 0.0
        var i = 1
        for theStr in self.theArr {
            let rect = theStr.boundingRectWithSize(CGSizeMake(1000, self.frame.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: NSDictionary.init(object: self.theFont, forKey: NSFontAttributeName) as? [String : AnyObject], context: nil)
            let temla = UILabel.init(frame: CGRectMake(0, -2, rect.width, rect.height))
            temla.tag = self.leftLabelTag
            temla.font = self.theFont
            temla.text = theStr as String
            temla.textColor = UIColor.blackColor()
            
            let temradio = markRadio.init(frame: CGRectMake(temla.frame.width + self.rightAndLeftSpace, 0, self.frame.height/2.0, self.frame.height/2.0))
            temradio.center = CGPointMake(temradio.center.x, self.frame.height/2.0)
            temradio.tag = self.rightButtonTag
            
            let temview = UIView.init(frame: CGRectMake(curOriginX, 0, temla.frame.width + temradio.frame.width + self.rightAndLeftSpace, self.frame.height))
            temview.tag = i
            temview.addSubview(temla)
            temview.addSubview(temradio)
            
            let tap = UITapGestureRecognizer.init(target: self, action: Selector("myClickAction:"))
            temview.addGestureRecognizer(tap)
            
            self.addSubview(temview)
            
            i++
            
            curOriginX += temview.frame.width + self.space
        }
        self.selectRadio(1)
    }
    /**
     创建自动高度view
     */
    func markViews_AutoHeight() {
        let subV: NSArray = self.subviews
        subV.enumerateObjectsUsingBlock { (obj: AnyObject, thei: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            obj.removeFromSuperview()
        }
        var curOriginX: CGFloat = 0.0
        var curOriginY: CGFloat = 0.0
        var lastView: UIView?
        var i = 1
        for theStr in self.theArr {
            let rect = theStr.boundingRectWithSize(CGSizeMake(1000, self.frame.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: NSDictionary.init(object: self.theFont, forKey: NSFontAttributeName) as? [String : AnyObject], context: nil)
            if let temLastView = lastView {
                let allWidth = temLastView.frame.width + temLastView.frame.origin.x + self.space + rect.width + self.rightAndLeftSpace + self.frame.height/2.0
                if allWidth > self.frame.width {
                    curOriginX = 0
                    curOriginY += self.frame.height
                }
            }
            
            let temla = UILabel.init(frame: CGRectMake(0, -2, rect.width, rect.height))
            temla.tag = self.leftLabelTag
            temla.font = self.theFont
            temla.text = theStr as String
            temla.textColor = UIColor.blackColor()
            
            let temradio = markRadio.init(frame: CGRectMake(temla.frame.width + self.rightAndLeftSpace, 0, self.frame.height/2.0, self.frame.height/2.0))
            temradio.center = CGPointMake(temradio.center.x, self.frame.height/2.0)
            temradio.tag = self.rightButtonTag
            
            let temview = UIView.init(frame: CGRectMake(curOriginX, curOriginY, temla.frame.width + temradio.frame.width + self.rightAndLeftSpace, self.frame.height))
            temview.tag = i
            temview.addSubview(temla)
            temview.addSubview(temradio)
            
            let tap = UITapGestureRecognizer.init(target: self, action: Selector("myClickAction:"))
            temview.addGestureRecognizer(tap)
            
            lastView = temview
            
            self.addSubview(temview)
            
            i++
            
            curOriginX += temview.frame.width + self.space
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, curOriginY + self.frame.height)
        self.selectRadio(1)
    }
    /**
     设置单选值
     
     - parameter theCur: 当前值，从1开始
     */
    func selectRadio(theCur: Int) {
        for var i=0;i<self.theArr.count;i++ {
            let temvi = self.viewWithTag(i+1)
            if let tem = temvi {
                let temRadio = tem.viewWithTag(self.rightButtonTag) as! markRadio
                temRadio.selected = false
            }
        }
        let temvi = self.viewWithTag(theCur)
        if let tem = temvi {
            let temRadio = tem.viewWithTag(self.rightButtonTag) as! markRadio
            temRadio.selected = true
            
            self.curValue = theCur
            self.theCB(cur: self.curValue)
        }
    }
    /**
     selector
     
     - parameter sender:
     */
    func myClickAction(sender: UITapGestureRecognizer) {
        self.selectRadio((sender.view?.tag)!)
    }
}
// 单选样式
class markRadio: UIButton {
    var selectedBgColor = UIColor.grayColor()
    var normalBgColor = UIColor.whiteColor()
    override var selected: Bool {
        willSet(newValue) {
            self.changeValue(newValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = self.normalBgColor
        self.layer.cornerRadius = frame.width/2.0
        self.layer.borderWidth = 1
        self.layer.borderColor = self.selectedBgColor.CGColor
        self.clipsToBounds = true
        self.userInteractionEnabled = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func changeValue(sel: Bool) {
        self.backgroundColor = sel ? self.selectedBgColor : self.normalBgColor
    }
}