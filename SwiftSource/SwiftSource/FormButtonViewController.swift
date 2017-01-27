
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class FormButtonViewController: UIViewController,UITextFieldDelegate
{
    let makeFormInstance = CustomField()
    let makeLabelInstance = CustomLabel()
    let makeButtonInstance = CustomButton()
    var messegeLabel:UILabel!
    var buttonMail:UIButton!
    var buttonNum:UIButton!
    
    //フォームが入力チェック済みかどうかを判定するフラグ
    var flagFormSMS = false
    var flagFormPIN = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "FormButtonView"
        
        
        
        
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
        
        
        //ボタン
        buttonMail = makeButtonInstance.createButton(px: UIScreen.main.bounds.size.width/4,
                                                    py: 200,
                                                    st: "mailpost",
                                                    ct: "name",
                                                    tag: 0)
        buttonMail.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        buttonMail.alpha = 0.4
        buttonMail.isUserInteractionEnabled = false
        self.view.addSubview(buttonMail)
        
        
        //SMS
        let formSMS = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                                py: 400,
                                                st: "",
                                                ct:"初期テキスト" ,
                                                tag: 1)
        formSMS.delegate = self
        formSMS.keyboardType = .numberPad
        self.view.addSubview(formSMS)
        
        
        
        //PIN
        let formPIN = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                                py: 500,
                                                st: "",
                                                ct:"初期テキスト" ,
                                                tag: 2)
        
        formPIN.delegate = self
        formPIN.keyboardType = .numberPad
        self.view.addSubview(formPIN)
        
        
        //ボタン
        buttonNum = makeButtonInstance.createButton(px: UIScreen.main.bounds.size.width/4,
                                                   py: 600,
                                                   st: "numpost",
                                                   ct: "name",
                                                   tag: 1)
        buttonNum.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        buttonNum.alpha = 0.4
        buttonNum.isUserInteractionEnabled = false
        self.view.addSubview(buttonNum)
        
        
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
                buttonMail.alpha = 0.4
                buttonMail.isUserInteractionEnabled = false
            }
            else
            {
                messegeLabel.textColor = UIColor.clear
                buttonMail.alpha = 1.0
                buttonMail.isUserInteractionEnabled = true
            }
        case 1://SMS 11
            if (textField.text?.characters.count)! < 11
            {
                buttonNum.alpha = 0.4
                buttonNum.isUserInteractionEnabled = false
                flagFormSMS = false
            }
            else
            {
                textField.text = (textField.text! as NSString).substring(to: 11)
                flagFormSMS = true
            }
        case 2://PIN 4
            if (textField.text?.characters.count)! < 4
            {
                buttonNum.alpha = 0.4
                buttonNum.isUserInteractionEnabled = false
                flagFormPIN = false
            }
            else
            {
                textField.text = (textField.text! as NSString).substring(to: 4)
                flagFormPIN = true
            }
        default:
            return true
        }
        
        if flagFormSMS && flagFormPIN
        {
            buttonNum.alpha = 1.0
            buttonNum.isUserInteractionEnabled = true
        }
        
        
        return true
    }
    func onTap(sender: UIButton){
        
        switch sender.tag {
        case 0:
            buttonMail.alpha = 0.4
            buttonMail.isUserInteractionEnabled = false
        case 1:
            print(sender.tag)
        default:
            print(sender.tag)
        }
    }
}
