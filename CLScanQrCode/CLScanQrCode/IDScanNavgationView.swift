//
//  HDNavgationView.swift
//  CloudscmSwift
//
//  Created by darren on 2017/10/10.
//  Copyright © 2017年 RexYoung. All rights reserved.
//

import UIKit

/// 屏幕宽度
var KScreenHeight = UIScreen.main.bounds.height
/// 屏幕高度
var KScreenWidth = UIScreen.main.bounds.width
/// 屏幕比例
var kScale = UIScreen.main.scale
/// 导航栏高度+状态栏(iphonex 88)
var KNavgationBarHeight: CGFloat = UIDevice.current.isX() == true ? 88:64
/// tabbar高度(iphonex 83)
var KTabBarHeight: CGFloat = UIDevice.current.isX() == true ? 83:49
/// iphonex 底部间距
var IphoneXBottomSpace: CGFloat = UIDevice.current.isX() == true ? 34:0

open class IDScanNavgationView: UIView {
    open lazy var titleLable:UILabel = {
        let titleLable = UILabel()
        titleLable.textAlignment = .center
        titleLable.text = "二维码/条码"
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLable
    }()

    public lazy var navLine:UIView = {
        let navLine = UIView()
        navLine.backgroundColor = UIColor.groupTableViewBackground
        return navLine
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLable)
        self.addSubview(self.navLine)
        initEventHendle()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initEventHendle() {
        self.titleLable.translatesAutoresizingMaskIntoConstraints = false
        self.navLine.translatesAutoresizingMaskIntoConstraints = false
        
        let titleY: CGFloat = UIDevice.current.isX() == true ? 40:20
        self.titleLable.addConstraint(NSLayoutConstraint.init(item: self.titleLable, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
        self.addConstraints([
            NSLayoutConstraint.init(item: self.titleLable, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 50),
            NSLayoutConstraint.init(item: self.titleLable, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: titleY),
            NSLayoutConstraint.init(item: self.titleLable, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -50)
            ])
        
        self.navLine.addConstraint(NSLayoutConstraint.init(item: self.navLine, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 1))
        self.addConstraints([
            NSLayoutConstraint.init(item: self.navLine, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.navLine, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.navLine, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            ])
    }
    override open func layoutSubviews() {
    }
}

extension UIDevice {
    func isX() -> Bool {
        let window = UIApplication.shared.keyWindow
        if #available(iOS 11.0, *) {
            let bottomSafeInset = window?.safeAreaInsets.bottom
            if (bottomSafeInset == 34.0 || bottomSafeInset == 21.0) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
