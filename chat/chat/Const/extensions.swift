//
//  extensions.swift
//  magic
//
//  Created by kent on 2017/05/05.
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.
//

import UIKit

extension UIColor
{
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor
    {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    class func hex ( _ hexStr : String, alpha : CGFloat) -> UIColor
    {
        var hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        
        if hexStr.characters.count == 3
        {
            var newHexStr = ""
            for c in hexStr.characters
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

