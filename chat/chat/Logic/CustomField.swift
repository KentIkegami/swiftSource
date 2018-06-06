//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class CustomField
{
    var textField:UITextField!
    var x:CGFloat = 0
    var y:CGFloat = 0
    var w:CGFloat = UIScreen.main.bounds.size.width*0.95/3
    var h:CGFloat = UIScreen.main.bounds.size.height*1/13.34
    var colorBG:UIColor = UIColor.hex("FFFFFF", alpha: 1)
    var colorT:UIColor = UIColor.hex(ColorAll.COLOR_FONT, alpha: 1)
    var fontSize:CGFloat = 20
    var colorBD = UIColor.hex(ColorAll.COLOR_MAIN, alpha: 0.5).cgColor
    
    func createField(px:CGFloat, py:CGFloat, st:String, ct:String, tag:Int)->UITextField
    {
        
        //サイズ、形関係
        textField = UITextField(frame: CGRect(x: x, y: y, width: w, height: h))
        textField.layer.position = CGPoint(x: px, y: py)
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5.0
        //背景関係
        textField.backgroundColor = colorBG
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = colorBD
        //文字関係
        textField.text = NSLocalizedString(st, comment: ct)
        textField.textColor = colorT
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.textAlignment = NSTextAlignment.center
        //その他
        textField.tag = tag
        //アンカーポイントの変更 CGPoint(x:0.5, y:0.5)
        textField.layer.anchorPoint = CGPoint(x:0.5, y:0)
        return textField
    }
    
    
}





