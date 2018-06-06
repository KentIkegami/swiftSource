//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class CustomLabel
{
    var label:UILabel!
    var x:CGFloat = 0
    var y:CGFloat = 0
    var w:CGFloat = UIScreen.main.bounds.size.width*0.95/3
    var h:CGFloat = UIScreen.main.bounds.size.height*1/13.34
    var colorBG:UIColor = UIColor.hex("25263F", alpha: 0.0)
    var colorT:UIColor = UIColor.hex(ColorAll.COLOR_FONT, alpha: 1)
    var fontSize:CGFloat = 20
    
    func createLabel(px:CGFloat, py:CGFloat, st:String, ct:String, tag:Int)->UILabel
    {
        
        //サイズ、形関係
        label = UILabel(frame: CGRect(x: x, y: y, width: w, height: h))
        label.layer.position = CGPoint(x: px, y: py)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5.0
        //背景関係
        label.backgroundColor = colorBG
        //文字関係
        label.text = NSLocalizedString(st, comment: ct)
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        label.textColor = colorT
        //label.shadowColor = UIColor.gray
        label.textAlignment = NSTextAlignment.left
        //アンカーポイントの変更 CGPoint(x:0.5, y:0.5)
        label.layer.anchorPoint = CGPoint(x:0.5, y:0)
        
        return label
    }
    
    func createBarLabel(st:String, ct:String)->UIView
    {
        let _view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
        _view.backgroundColor = UIColor.hex(ColorAll.COLOR_MAIN, alpha: 1.0)
        //サイズ、形関係
        label = UILabel(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 44))
        //背景関係
        label.backgroundColor = UIColor.hex(ColorAll.COLOR_MAIN, alpha: 1.0)
        //文字関係
        label.text = NSLocalizedString(st, comment: ct)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.hex(ColorAll.COLOR_BASE, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        _view.addSubview(label)
        
        return _view
    }
    
    func createBarLabelPre(st:String, ct:String)->UIView
    {
        let _view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
        _view.backgroundColor = UIColor.hex(ColorAll.COLOR_MAIN, alpha: 1.0)
        //サイズ、形関係
        label = UILabel(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 44))
        //背景関係
        label.backgroundColor = UIColor.hex(ColorAll.COLOR_MAIN, alpha: 1.0)
        //文字関係
        label.text = NSLocalizedString(st, comment: ct)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.hex(ColorAll.COLOR_BASE, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        _view.addSubview(label)
        
        return _view
    }
    
}

