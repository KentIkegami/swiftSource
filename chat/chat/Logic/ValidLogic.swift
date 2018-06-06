//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class ValidLogic
{
    //Unicodeで何byte文字かチェック　true:3byte文字で構成されている false:4byte文字が含まれる
    func charactersUnicodeByteCountChecker(str:String) -> Bool
    {
        var isByteCount3:Bool = true
        
        for _value in str.characters
        {
            //一文字づつUnicodeで何byte文字かチェック
            let unicodeByteCount:Int = _value.description.utf8.count
            
            if unicodeByteCount > 3
            {
                isByteCount3 = false
                break
            }
        }
        
        return isByteCount3
    }
    
    //メールアドレスチェック
    func isValidEmail(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: string)
        return result
    }
    
    
    
}

