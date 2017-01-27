//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class CustomLabel
{
    var label:UILabel!
    var x:CGFloat = 0
    var y:CGFloat = 0
    var w:CGFloat = UIScreen.main.bounds.size.width*0.95/3
    var h:CGFloat = 50
    var colorBG:UIColor = UIColor.hex("25263F", alpha: 0.8)
    var colorT:UIColor = UIColor.hex("FFFFFF", alpha: 0.8)
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
        label.textColor = colorT
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        //label.shadowColor = UIColor.gray
        label.textAlignment = NSTextAlignment.center
        
        return label
    }
}
