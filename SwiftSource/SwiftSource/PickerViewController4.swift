
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class PickerViewController4: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate
{
    private var _NYearMonthDay:String!
    private var _NHour:String!
    private var _NMin:String!
    
    private var APickerBaseView:UIView!
    private var APicker: UIPickerView!
    private var ATextField = UITextField()
    private var AYearMonthDay: [String] = []
    private var AHour: [String] = []
    private var AMin: [String] = []
    private var AAll: [[String]]!
    
    private var BPickerBaseView:UIView!
    private var BPicker: UIPickerView!
    private var BTextField = UITextField()
    private var BYearMonthDay: [String] = []
    private var BHour: [String] = []
    private var BMin: [String] = []
    private var BAll: [[String]]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "PickerView4"
        
        //現在時刻取得
        makeNowTimeUTC()
        //配列の初期化
        getYMArray()
        
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
    func makeNowTimeUTC(){
        //現在のデバイス時間をsystemTimeで出力
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "yyyyMMddHHmmss"
        let nowTimeUTC = formatter.string(from: now as Date)
        
        //年月日
        formatter.dateFormat = "yyyy年M月d日"
        _NYearMonthDay = formatter.string(from: now as Date)
        
        //時
        formatter.dateFormat = "HH"
        _NHour = formatter.string(from: now as Date)
        
        //分
        formatter.dateFormat = "mm"
        _NMin = formatter.string(from: now as Date)
        print(nowTimeUTC)
        print("\(_NYearMonthDay!),\(_NHour!),\(_NMin!)")
    }
    
    //年月配列の取得
    func getYMArray() {
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        formatter.dateFormat = "yyyy年M月d日"
        
        var components = DateComponents()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        AYearMonthDay.append("----年--月--日")
        BYearMonthDay.append("----年--月--日")
        for i in 0 ..< 100 {
            components.setValue(i,for: Calendar.Component.day)
            let wk = calendar.date(byAdding: components, to: Date())!
            let wkStr = formatter.string(from: wk)
            AYearMonthDay.append(wkStr)
            BYearMonthDay.append(wkStr)
        }
    }
    
    
    
    
    func makePickerBaseView(_ isA:Bool) -> UIView
    {
        
        
        //配列の初期化
        if isA
        {
            
            AHour = [
                     " 0"," 1"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9",
                     "10","11","12","13","14","15","16","17","18","19",
                     "20","21","22","23"]
            
            for _ in 1..<100
            {
                AMin += ["00","01","02","03","04","05","06","07","08","09",
                         "10","11","12","13","14","15","16","17","18","19",
                         "20","21","22","23","24","25","26","27","28","29",
                         "30","31","32","33","34","35","36","37","38","39",
                         "40","41","42","43","44","45","46","47","48","49",
                         "50","51","52","53","54","55","56","57","58","59"]
            }
            
            AAll = [AYearMonthDay,AHour,AMin]
        }else{
            
            
            BHour = [
                     " 0"," 1"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9",
                     "10","11","12","13","14","15","16","17","18","19",
                     "20","21","22","23"]
            
            for _ in 1..<100
            {
                BMin += ["00","01","02","03","04","05","06","07","08","09",
                         "10","11","12","13","14","15","16","17","18","19",
                         "20","21","22","23","24","25","26","27","28","29",
                         "30","31","32","33","34","35","36","37","38","39",
                         "40","41","42","43","44","45","46","47","48","49",
                         "50","51","52","53","54","55","56","57","58","59"]
            }
            
            BAll = [BYearMonthDay,BHour,BMin]
        }
        
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
        myTextField.text = isA ? "\(_NYearMonthDay!)  \(_NHour!):\(_NMin!)" : "----年--月--日  0:00"
        
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
        myTextField.text = "----年--月--日  --:00"
        myTextField.textAlignment = .center
        return myTextField
    }
    
    //ピッカービューの作成
    func makePicker(_ isA:Bool) -> UIPickerView
    {
        let myPicker:UIPickerView!
        myPicker = UIPickerView()
        myPicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200.0)
        myPicker.layer.position = CGPoint(x:0, y:0)
        myPicker.backgroundColor = isA ? UIColor.cyan : UIColor.red
        myPicker.tag = isA ? 0 : 1
        myPicker.delegate = self
        myPicker.dataSource = self
        //初期選択位置の設定
        if isA {
            myPicker.selectRow(1, inComponent: 0, animated: true)
            myPicker.selectRow(1, inComponent: 1, animated: true)
            myPicker.selectRow(60*50, inComponent: 2, animated: true)
        }else{
            myPicker.selectRow(60*50, inComponent: 2, animated: true)
        }
        return myPicker
    }
    
    //入力領域を引っ込める
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        ATextField.endEditing(true)
        BTextField.endEditing(true)
    }
    
    //ホイールの幅
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if pickerView.tag == 0
        {
            return AAll.count
        }
        else
        {
            return BAll.count
        }
    }
    
    //ホイールサイズを返すメソッド
    func pickerView(_ pickerView: UIPickerView, widthForComponent component:Int) -> CGFloat
    {
        let w = UIScreen.main.bounds.size.width-30
        switch component {
        case 0:
            return w*3/5
        case 1:
            return w*1/5
        case 2:
            return w*1/5
        default:
            return w*1/3
        }
    }
    
    //pickerに表示する行数を返すデータソースメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView.tag == 0
        {
            return AAll[component].count
        }
        else
        {
            return BAll[component].count
        }
    }
    
    //pickerに表示する値を返すデリゲートメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if pickerView.tag == 0
        {
            return BAll[component][row]
        }
        else
        {
            return BAll[component][row]
        }
    }
    
    //データを返すメソッド
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        
        if pickerView.tag == 0
        {
            pickerLabel.text = AAll[component][row]
        }
        else
        {
            pickerLabel.text = BAll[component][row]
        }
        
        switch component {
        case 0:
            pickerLabel.font = UIFont.systemFont(ofSize: 24)
            pickerLabel.textAlignment = NSTextAlignment.right
        case 1:
            pickerLabel.font = UIFont.systemFont(ofSize: 24)
            pickerLabel.textAlignment = NSTextAlignment.center
        case 2:
            pickerLabel.font = UIFont.systemFont(ofSize: 24)
            pickerLabel.textAlignment = NSTextAlignment.left
        default:
            pickerLabel.font = UIFont.systemFont(ofSize: 24)
            pickerLabel.textAlignment = NSTextAlignment.center
        }
        return pickerLabel
    }
    
    
    //pickerが選択時デリゲートメソッド
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 0
        {
            let _AYearMonthDay = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!
            let _AHour = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!
            let _AMin = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 2), forComponent: 2)!
            
            //テキストビューの値変更
            ATextField.text = "\(_AYearMonthDay)　\(_AHour):\(_AMin)"
            print("\(_AYearMonthDay),\(_AHour),\(_AMin)")
            
        }
        else
        {
            let _BYearMonthDay = self.pickerView(BPicker, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!
            let _BHour = self.pickerView(BPicker, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!
            let _BMin = self.pickerView(BPicker, titleForRow: pickerView.selectedRow(inComponent: 2), forComponent: 2)!
            
            //テキストビューの値変更
            BTextField.text = "\(_BYearMonthDay)  \(_BHour):\(_BMin)"
            print("\(_BYearMonthDay),\(_BHour),\(_BMin)")
        }
        pickerValidation()
    }
    
    
    //バリデーション
    func pickerValidation(){
        let APickerNum0 = APicker.selectedRow(inComponent: 0)
        let APickerNum1 = APicker.selectedRow(inComponent: 1)
        let APickerNum2 = APicker.selectedRow(inComponent: 2)
        let BPickerNum0 = BPicker.selectedRow(inComponent: 0)
        let BPickerNum1 = BPicker.selectedRow(inComponent: 1)
        let BPickerNum2 = BPicker.selectedRow(inComponent: 2)
        print("\(APickerNum0),\(APickerNum1),\(APickerNum2)")
        print("\(BPickerNum0),\(BPickerNum1),\(BPickerNum2)")
    
    }
    
    
}


