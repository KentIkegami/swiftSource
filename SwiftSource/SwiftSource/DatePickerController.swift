
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class DatePickerController: UIViewController, UIPickerViewDelegate,UITextFieldDelegate
{
    private var nowDateandTime:String!
    private var AselectedDate:Date!
    private var BselectedDate:Date!
    
    private var APickerBaseView:UIView!
    private var APicker: UIDatePicker!
    private var ATextField = UITextField()

    private var BPickerBaseView:UIView!
    private var BPicker: UIDatePicker!
    private var BTextField = UITextField()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "DatePicker"
        
        //現在時刻取得
        makeNowDate()
        
        APickerBaseView = makePickerBaseView(true)
        self.view.addSubview(APickerBaseView)
        
        BPickerBaseView = makePickerBaseView(false)
        self.view.addSubview(BPickerBaseView)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //現在時刻取得
    func makeNowDate(){
        //現在のデバイス時間をsystemTimeで出力
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "yyyy年M月d日 HH:mm"
        nowDateandTime = formatter.string(from: now as Date)
        
        //内部変数の更新
        AselectedDate=now as Date!
        BselectedDate=now as Date!
    }
    
    func makePickerBaseView(_ isA:Bool) -> UIView
    {
        //パーツを乗せるビュー
        let baseView = UIView()
        baseView.backgroundColor =  isA ? UIColor.cyan : UIColor.red
        baseView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width*0.9, height: 50)
        if isA {
            baseView.layer.position = CGPoint(x: CGFloat(UIScreen.main.bounds.size.width)/2,y: CGFloat(UIScreen.main.bounds.size.height)/2)
        }else{
            baseView.layer.position = CGPoint(x: CGFloat(UIScreen.main.bounds.size.width)/2,y: CGFloat(UIScreen.main.bounds.size.height)/2+60)
        }
        baseView.layer.cornerRadius = 5
        
        //文字
        let ji:UILabel = UILabel()
        ji.frame = CGRect(x: 10,
                          y: 1,
                          width: CGFloat(UIScreen.main.bounds.size.width)*0.1,
                          height: 48)
        ji.text = isA ? "start" : "end"
        baseView.addSubview(ji)
        
        //baseViewにテキストフィールドを乗せる
        var myTextField = UITextField()
        myTextField = makeTextField(isA)
        myTextField.text = isA ? "\(nowDateandTime!)" : "----年--月--日  0:00"
        
        if isA {
            ATextField = myTextField
            baseView.addSubview(ATextField)
        }else{
            BTextField = myTextField
            baseView.addSubview(BTextField)
        }
        return baseView
    }
    
    func makeTextField(_ isA:Bool) -> UITextField
    {
        let myTextField:UITextField!
        myTextField = UITextField(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width*0.7, height: 40))
        myTextField.layer.position = CGPoint(x: UIScreen.main.bounds.size.width*0.50, y: 25)
        myTextField.delegate = self
        myTextField.layer.cornerRadius = 5.0
        myTextField.layer.borderWidth = 1.5
        myTextField.layer.borderColor = UIColor.white.cgColor
        myTextField.font = UIFont.systemFont(ofSize: CGFloat(20))
        myTextField.textColor = UIColor.black
        myTextField.backgroundColor = UIColor.white
        myTextField.tintColor = UIColor.clear //キャレット(カーソル)を消す。
        //ここでピッカービューをセットする。
        if isA {
            APicker = makePicker(isA)
            myTextField.inputView = APicker
        }else{
            BPicker = makePicker(isA)
            myTextField.inputView = BPicker
        }
        myTextField.textAlignment = .center
        return myTextField
    }
    
    //ピッカービューの作成
    func makePicker(_ isA:Bool) -> UIDatePicker
    {
        let myPicker:UIDatePicker!
        myPicker = UIDatePicker()
        myPicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200.0)
        myPicker.layer.position = CGPoint(x:0, y:0)
        myPicker.backgroundColor = isA ? UIColor.cyan : UIColor.red
        myPicker.tag = isA ? 0 : 1
        myPicker.datePickerMode = .dateAndTime
        myPicker.timeZone = NSTimeZone.local
        //制約
        myPicker.minimumDate = Date()
        myPicker.maximumDate = NSDate(timeInterval: (60*60*24)*100, since: Date() as Date) as Date
        //デリゲートの代わり
        myPicker.addTarget(self, action:  #selector(onDidChangeDate(sender:)), for: .valueChanged)
        
        return myPicker
    }
    
    //入力領域を引っ込める
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        ATextField.endEditing(true)
        BTextField.endEditing(true)
    }
    
    //pickerが選択時デリゲートメソッド
    internal func onDidChangeDate(sender: UIDatePicker){
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日 HH:mm"
        
        //テキストフィールドと内部変数の更新
        let mySelectedDate: NSString = formatter.string(from: sender.date) as NSString
        if sender.tag == 0
        {
            ATextField.text = mySelectedDate as String
            AselectedDate = sender.date
        }
        else
        {
            BTextField.text = mySelectedDate as String
            BselectedDate = sender.date
        }
        
        //ピッカー制約の更新
        if sender.tag == 0
        {
            BPicker.minimumDate = AselectedDate
            
            if AselectedDate > BselectedDate
            {
                BTextField.text = (formatter.string(from: AselectedDate) as NSString) as String
            }
        }
        
    }
}


