//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class CustomButton
{
    
    var myButton: UIButton!
    
    var x:CGFloat = 0
    var y:CGFloat = 0
    var w:CGFloat = UIScreen.main.bounds.size.width*0.95/3
    var h:CGFloat = UIScreen.main.bounds.size.height*1/13.34
    var colorNBG:UIColor = UIColor.hex(ColorAll.COLOR_MAIN, alpha: 0.8)
    var colorHBG:UIColor = UIColor.hex(ColorAll.COLOR_MAIN_DARK, alpha: 0.8)
    var colorNT:UIColor = UIColor.hex("FFFFFF", alpha: 1)
    var colorHT:UIColor = UIColor.hex("dbd9d9", alpha: 1)
    
    func createButton(px:CGFloat, py:CGFloat, st:String, ct:String, tag:Int)->UIButton{
        
        myButton = UIButton()
        myButton.tag = tag
        myButton.frame = CGRect(x: x,y: y,width: w,height: h)
        myButton.layer.position = CGPoint(x: px, y: py)
        //背景関係
        myButton.setBackgroundImage(self.createImageFromUIColor(color: colorNBG), for: .normal)
        myButton.setBackgroundImage(self.createImageFromUIColor(color: colorHBG), for: .highlighted)
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 5.0
        myButton.showsTouchWhenHighlighted = true
        //タイトル関係
        myButton.setTitle(NSLocalizedString(st, comment: ct), for: .normal)
        myButton.setTitleColor(colorNT, for: .normal)
        myButton.setTitle(NSLocalizedString(st, comment: ct), for: .highlighted)
        myButton.setTitleColor(colorHT, for: .highlighted)
        //影関係
        //myButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        //myButton.layer.shadowOpacity = 0.8
        //myButton.layer.shadowColor = UIColor.hex("25263F", alpha: 0.5).cgColor
        
        //myButton.layer.borderColor = UIColor.red.cgColor
        //myButton.layer.borderWidth = 2
        //アンカーポイントの変更 CGPoint(x:0.5, y:0.5)
        myButton.layer.anchorPoint = CGPoint(x:0.5, y:0)
        //複数選択制御
        myButton.isExclusiveTouch = true
        
        return myButton
    }
    
    private func createImageFromUIColor(color: UIColor) -> UIImage {
        // 1x1のbitmapを作成
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        // bitmapを塗りつぶし
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        // UIImageに変換
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}

//(UIScreen.main.bounds.size.width)  375
//aButton.addTarget(self, action:  #selector(onTap(sender:)), for: .touchDown)
//
//internal func onTap(sender: UIButton){
//
//}

