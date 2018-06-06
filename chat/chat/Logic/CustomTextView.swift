//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class CustomTextView
{
    var textTextView:UITextView!
    var x:CGFloat = 0
    var y:CGFloat = 0
    var w:CGFloat = UIScreen.main.bounds.size.width*0.95/3
    var h:CGFloat = UIScreen.main.bounds.size.height*1/13.34
    var colorBG:UIColor = UIColor.hex("FFFFFF", alpha: 1)
    var colorT:UIColor = UIColor.hex(ColorAll.COLOR_FONT, alpha: 1)
    var fontSize:CGFloat = 20
    var colorBD = UIColor.hex(ColorAll.COLOR_MAIN, alpha: 0.5).cgColor
    
    func createTextView(px:CGFloat, py:CGFloat, st:String, ct:String, tag:Int)->UITextView
    {
        
        //サイズ、形関係
        textTextView = UITextView(frame: CGRect(x: x, y: y, width: w, height: h))
        textTextView.layer.position = CGPoint(x: px, y: py)
        textTextView.layer.masksToBounds = true
        textTextView.layer.cornerRadius = 5.0
        //背景関係
        textTextView.backgroundColor = colorBG
        textTextView.layer.borderWidth = 1.5
        textTextView.layer.borderColor = colorBD
        //文字関係
        textTextView.text = NSLocalizedString(st, comment: ct)
        textTextView.textColor = colorT
        textTextView.font = UIFont.systemFont(ofSize: fontSize)
        textTextView.textAlignment = NSTextAlignment.center
        //その他
        textTextView.tag = tag
        //アンカーポイントの変更 CGPoint(x:0.5, y:0.5)
        textTextView.layer.anchorPoint = CGPoint(x:0.5, y:0)
        return textTextView
    }
    
    
}





