//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class CustomField
{
    var textField:UITextField!
    var x:CGFloat = 0
    var y:CGFloat = 0
    var w:CGFloat = UIScreen.main.bounds.size.width*0.95/3
    var h:CGFloat = 50
    var colorBG:UIColor = UIColor.hex("25263F", alpha: 0.8)
    var colorT:UIColor = UIColor.hex("FFFFFF", alpha: 0.8)
    
    func createField(px:CGFloat, py:CGFloat, st:String, ct:String, tag:Int)->UITextField
    {
        //サイズ、形関係
        textField = UITextField(frame: CGRect(x: x, y: y, width: w, height: h))
        textField.layer.position = CGPoint(x: px, y: py)
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5.0
        //背景関係
        textField.backgroundColor = colorBG
        //文字関係
        textField.text = NSLocalizedString(st, comment: ct)
        textField.textColor = colorT
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = NSTextAlignment.center
        //その他
        textField.tag = tag
        return textField
    }
    
    func isValidEmail(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: string)
        return result
    }
    

}



////キーボード引っ込め
//override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    self.view.endEditing(true)
//    //myTextField.endEditing(true)
//}
