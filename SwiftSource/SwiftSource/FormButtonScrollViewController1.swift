
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class FormButtonScrollViewController1: UIViewController,UITextFieldDelegate
{
    
    let makeLabelInstance = CustomLabel()
    let makeFormInstance = CustomField()
    let makeButtonInstance = CustomButton()
    var messegeLabel:UILabel!
    var buttonMail:UIButton!
    var buttonNum:UIButton!
    
    //フォームが入力チェック済みかどうかを判定するフラグ
    var flagFormSMS = false
    var flagFormPIN = false
    
    /*キーボード調整用1/3*/
    //フォーム上下用スクロールview
    var scrollView = UIScrollView()
    //フォーカスされているフィールド格納用
    var activeTextField: UITextField?
    
    override func viewDidLoad()
    {

        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "FormButtonView"
        
        /*キーボード調整用2/3*/
        self.scrollView.frame = CGRect(x: 0,y: 0,width: CGFloat(UIScreen.main.bounds.size.width),height: CGFloat(UIScreen.main.bounds.size.height))
        
        // Notification の追加
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil
        )
        
        
        
        
        makeFormInstance.w = 300
        //mailaddress
        let formMail = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                                 py: 50,
                                                 st: "",
                                                 ct:"初期テキスト" ,
                                                 tag: 0)
        formMail.delegate = self
        formMail.keyboardType = .emailAddress
        self.scrollView.addSubview(formMail)
        
        
        //メールアドレスのバリデートメッセージ
        makeLabelInstance.colorBG = UIColor.clear
        makeLabelInstance.colorT = UIColor.clear
        makeLabelInstance.fontSize = 15
        makeLabelInstance.h = 20
        makeLabelInstance.w = UIScreen.main.bounds.size.width*0.9
        messegeLabel = makeLabelInstance.createLabel(px: UIScreen.main.bounds.size.width/2,
                                                   py: 100,
                                                   st: "メールアドレスを入力してください。",
                                                   ct: "メッセージ",
                                                   tag: 0)
        messegeLabel.textAlignment = .left
        self.scrollView.addSubview(messegeLabel)
        
        
        //ボタン
        buttonMail = makeButtonInstance.createButton(px: UIScreen.main.bounds.size.width/4,
                                                   py: 150,
                                                   st: "mailpost",
                                                   ct: "name",
                                                   tag: 0)
        buttonMail.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        buttonMail.alpha = 0.4
        buttonMail.isUserInteractionEnabled = false
        self.scrollView.addSubview(buttonMail)
        
        
        //SMS
        let formSMS = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                                py: 350,
                                                st: "",
                                                ct:"初期テキスト" ,
                                                tag: 1)
        formSMS.delegate = self
        formSMS.keyboardType = .numberPad
        self.scrollView.addSubview(formSMS)
        
        
        
        //PIN
        let formPIN = makeFormInstance.createField(px: UIScreen.main.bounds.size.width/2,
                                                py: 450,
                                                st: "",
                                                ct:"初期テキスト" ,
                                                tag: 2)
        
        formPIN.delegate = self
        formPIN.keyboardType = .numberPad
        self.scrollView.addSubview(formPIN)
        
        
        //ボタン
        buttonNum = makeButtonInstance.createButton(px: UIScreen.main.bounds.size.width/4,
                                                  py: 550,
                                                  st: "numpost",
                                                  ct: "name",
                                                  tag: 1)
        buttonNum.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        buttonNum.alpha = 0.4
        buttonNum.isUserInteractionEnabled = false
        self.scrollView.addSubview(buttonNum)
        
        
        self.scrollView.contentSize = CGSize(width: CGFloat(UIScreen.main.bounds.size.width),
                                             height: CGFloat(UIScreen.main.bounds.size.height)-(navigationController?.navigationBar.frame.size.height)!-20)
        self.view.addSubview(self.scrollView)
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /*-------------------------------------------------------------------------
     TextViewDelegate
     -------------------------------------------------------------------------*/
    
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
    
    

    /*キーボード調整用3/3*/
    // UITeixtFieldが選択された場合
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.activeTextField = textField
        return true
    }

    // キーボード出現時
    func keyboardWillShow(notification: NSNotification) {
        self.scrollView.contentOffset.y = activeTextField!.frame.origin.y-200
    }
    
    // キーボード閉じる時
    func keyboardWillHide(notification: NSNotification) {
         self.scrollView.contentOffset.y = -(navigationController?.navigationBar.frame.size.height)!-20
    }
    
    /*-------------------------------------------------------------------------
     Action&Event Methods
     -------------------------------------------------------------------------*/
    func onTap(sender: UIButton){
        
        switch sender.tag {
        case 0:
            buttonMail.alpha = 0.4
            buttonMail.isUserInteractionEnabled = false
        default:
            print(#function)
        }
    }
}
