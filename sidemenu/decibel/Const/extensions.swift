//
//  extentions.swift
//  typeb
//
//  Created by inf on 2017/12/11.
//  Copyright © 2017年 inf. All rights reserved.
//

import UIKit
extension UITextField
{
    // コピー・ペースト・選択等のメニュー非表示
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        return false
    }
}

extension UIColor
{
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor
    {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    class func hex ( _ hexStr : String, alpha : CGFloat) -> UIColor
    {
        var hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        
        if hexStr.count == 3
        {
            var newHexStr = ""
            for c in hexStr
            {
                newHexStr += "\(c)\(c)"
            }
            hexStr = newHexStr
        }
        
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color)
        {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        }
        else
        {
            print("invalid hex string")
            return UIColor.white
        }
    }
}


//スクロールビューでタッチイベント検知
extension UIScrollView
{
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.next?.touchesBegan(touches, with: event)
    }
}

//非公開BarItem
extension UIBarButtonItem {
    enum HiddenItem: Int {
        case Arrow = 100
        case Back = 101
        case Forward = 102
        case Up = 103
        case Down = 104
    }
    
    convenience init(barButtonHiddenItem: HiddenItem, target: AnyObject?, action: Selector?) {
        let systemItem = UIBarButtonSystemItem(rawValue: barButtonHiddenItem.rawValue)
        self.init(barButtonSystemItem: systemItem!, target: target, action: action)
    }
}


