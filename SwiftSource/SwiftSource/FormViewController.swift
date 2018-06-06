
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class FormViewController: UIViewController,UITextFieldDelegate
{
    let makeFormInstance = CustomField()
    let makeLabelInstance = CustomLabel()
    var messegeLabel:UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "FormView"
        
        //メールアドレスのバリデートメッセージ
        makeLabelInstance.colorBG = UIColor.clear
        makeLabelInstance.colorT = UIColor.clear
        makeLabelInstance.fontSize = 15
        makeLabelInstance.h = 20
        makeLabelInstance.w = UIScreen.main.bounds.size.width*0.9
        messegeLabel = makeLabelInstance.createLabel(px: UIScreen.main.bounds.size.width/2,
                                    py: 150,
                                    st: "メールアドレスを入力してください。",
                                    ct: "メッセージ",
                                    tag: 0)
        messegeLabel.textAlignment = .left
        self.view.addSubview(messegeLabel)
        
        
        makeFormInstance.w = 300
        //mailaddress
        let formMail = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                   py: 100,
                                   st: "",
                                   ct:"初期テキスト" ,
                                   tag: 0)
        formMail.delegate = self
        formMail.keyboardType = .emailAddress
        self.view.addSubview(formMail)
        
        
        //SMS
        let formSMS = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                              py: 200,
                                              st: "",
                                              ct:"初期テキスト" ,
                                              tag: 1)
        formSMS.delegate = self
        formSMS.keyboardType = .numberPad
        self.view.addSubview(formSMS)
        
        
        
        //PIN
        let formPIN = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                              py: 300,
                                              st: "",
                                              ct:"初期テキスト" ,
                                              tag: 2)
        
        formPIN.delegate = self
        formPIN.keyboardType = .numberPad
        self.view.addSubview(formPIN)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //どこかをタッチしたら呼び出されるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    //改行、または、Returnキーが押されたら呼び出されるメソッド
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    
    // フォーカスが外れる際に呼び出されるメソッド
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        switch textField.tag {
        case 0://mailaddress
            if !makeFormInstance.isValidEmail(textField.text!)
            {
                messegeLabel.textColor = UIColor.red
            }
            else
            {
                messegeLabel.textColor = UIColor.clear
            }
        case 1://SMS 11
            if (textField.text?.count)! > 11
            {
                textField.text = (textField.text! as NSString).substring(to: 11)
            }
        case 2://PIN 4
            if (textField.text?.count)! > 4
            {
                textField.text = (textField.text! as NSString).substring(to: 4)
            }
        default:
            return true
        }
        return true
    }
}
