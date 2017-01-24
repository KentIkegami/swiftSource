
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class PickerViewController3: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate
{
    private var _NYearMonth:String!
    private var _NDay:String!
    private var _NHour:String!
    private var _NMin:String!
    
    private var APickerBaseView:UIView!
    private var APicker: UIPickerView!
    private var ATextField = UITextField()
    private var AYearMonth: [String] = []
    private var ADay: [String] = []
    private var AHour: [String] = []
    private var AMin: [String] = []
    private var AAll: [[String]]!
    
    private var BPickerBaseView:UIView!
    private var BPicker: UIPickerView!
    private var BTextField = UITextField()
    private var BYearMonth: [String] = []
    private var BDay: [String] = []
    private var BHour: [String] = []
    private var BMin: [String] = []
    private var BAll: [[String]]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "PickerView3"
        
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
        
        //年月
        formatter.dateFormat = "yyyy年M月"
        _NYearMonth = formatter.string(from: now as Date)
        
        //日
        formatter.dateFormat = "d日"
        _NDay = formatter.string(from: now as Date)
        
        //時
        formatter.dateFormat = "HH"
        _NHour = formatter.string(from: now as Date)
        
        //分
        formatter.dateFormat = "mm"
        _NMin = formatter.string(from: now as Date)
        print(nowTimeUTC)
        print("\(_NYearMonth!),\(_NDay!),\(_NHour!),\(_NMin!)")
    }
    
    //年月配列の取得
    func getYMArray() {
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        formatter.dateFormat = "yyyy年M月"
        
        var components = DateComponents()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        for i in 0 ..< 12 {
            
            components.setValue(i,for: Calendar.Component.month)
            let wk = calendar.date(byAdding: components, to: Date())!
            let wkStr = formatter.string(from: wk)
            AYearMonth.append(wkStr)
            BYearMonth.append(wkStr)
        }
    }
    


    
    func makePickerBaseView(_ isA:Bool) -> UIView
    {
        
        
        //配列の初期化
        if isA
        {

            ADay = ["--日",
                    " 1日"," 2日"," 3日"," 4日"," 5日"," 6日"," 7日"," 8日"," 9日","10日",
                    "11日","12日","13日","14日","15日","16日","17日","18日","19日","20日",
                    "21日","22日","23日","24日","25日","26日","27日","28日","29日","30日","31日"]
            
            AHour = ["--",
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
            
            AAll = [AYearMonth,ADay,AHour,AMin]
        }else{

            BDay = ["--日",
                    " 1日"," 2日"," 3日"," 4日"," 5日"," 6日"," 7日"," 8日"," 9日","10日",
                    "11日","12日","13日","14日","15日","16日","17日","18日","19日","20日",
                    "21日","22日","23日","24日","25日","26日","27日","28日","29日","30日","31日"]
            
            BHour = ["--",
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
            
            BAll = [BYearMonth,BDay,BHour,BMin]
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
        myTextField.text = isA ? "\(_NYearMonth!) \(_NDay!) \(_NHour!):\(_NMin!)" : "----年--月 --日 --:00"
        
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
        myTextField.text = "----年--月 --日 --:00"
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
            myPicker.selectRow(6, inComponent: 2, animated: true)
            myPicker.selectRow(6, inComponent: 3, animated: true)
        }else{
            myPicker.selectRow(60*50, inComponent: 3, animated: true)
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
            return w*6/15
        case 1:
            return w*4/15
        case 2:
            return w*2/15
        case 3:
            return w*2/15
        default:
            return w*1/4
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
        case 3:
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
            let _AYearMonth = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!
            let _ADay = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!
            let _AHour = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 2), forComponent: 2)!
            let _AMin = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 3), forComponent: 3)!
            
            //テキストビューの値変更
            ATextField.text = "\(_AYearMonth) \(_ADay)　\(_AHour):\(_AMin)"
            print("\(_AYearMonth),\(_ADay),\(_AHour),\(_AMin)")
        }
        else
        {
            let _BYearMonth = self.pickerView(BPicker, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!
            let _BDay = self.pickerView(BPicker, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!
            let _BHour = self.pickerView(BPicker, titleForRow: pickerView.selectedRow(inComponent: 2), forComponent: 2)!
            let _BMin = self.pickerView(BPicker, titleForRow: pickerView.selectedRow(inComponent: 3), forComponent: 3)!
            
            //テキストビューの値変更
            BTextField.text = "\(_BYearMonth) \(_BDay)　\(_BHour):\(_BMin)"
            print("\(_BYearMonth),\(_BDay),\(_BHour),\(_BMin)")
        }
    }
    
    
    //バリデーション
    
    
}


//let str = nowTimeUTC
//
//
//var startIndex = str.index(str.startIndex, offsetBy: 0) // 開始位置
//var endIndex = str.index(startIndex, offsetBy: 4) // 長さ
//_NYearMonth = str.substring(with: startIndex..<endIndex)
//
//startIndex = str.index(str.startIndex, offsetBy: 6) // 開始位置
//endIndex = str.index(startIndex, offsetBy: 2) // 長さ
//_NDay = str.substring(with: startIndex..<endIndex)
//
//startIndex = str.index(str.startIndex, offsetBy: 8) // 開始位置
//endIndex = str.index(startIndex, offsetBy: 2) // 長さ
//_NHour = str.substring(with: startIndex..<endIndex)
//
//startIndex = str.index(str.startIndex, offsetBy: 10) // 開始位置
//endIndex = str.index(startIndex, offsetBy: 2) // 長さ
//_NMin = str.substring(with: startIndex..<endIndex)
//
//print("\(_NYearMonth),\(_NDay),\(_NHour),\(_NMin)")


////配列の初期化
//if isA
//{
//    AYearMonth = ["----年--月","2017年1月","2017年2月","2017年3月","2017年4月","2017年5月",
//                  "2017年6月","2017年7月","2017年8月","2017年9月","2017年10月","2017年11月","2017年12月"]
//    ADay = ["--日",
//            " 1日"," 2日"," 3日"," 4日"," 5日"," 6日"," 7日"," 8日"," 9日","10日",
//            "11日","12日","13日","14日","15日","16日","17日","18日","19日","20日",
//            "21日","22日","23日","24日","25日","26日","27日","28日","29日","30日","31日"]
//    
//    AHour = ["--",
//             " 0"," 1"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9",
//             "10","11","12","13","14","15","16","17","18","19",
//             "20","21","22","23"]
//    
//    for _ in 1..<100
//    {
//        AMin += ["00","01","02","03","04","05","06","07","08","09",
//                 "10","11","12","13","14","15","16","17","18","19",
//                 "20","21","22","23","24","25","26","27","28","29",
//                 "30","31","32","33","34","35","36","37","38","39",
//                 "40","41","42","43","44","45","46","47","48","49",
//                 "50","51","52","53","54","55","56","57","58","59"]
//    }
//    
//    AAll = [AYearMonth,ADay,AHour,AMin]
//}else{
//    BYearMonth = ["----年--月","2017年1月","2017年2月","2017年3月","2017年4月","2017年5月",
//                  "2017年6月","2017年7月","2017年8月","2017年9月","2017年10月","2017年11月","2017年12月"]
//    BDay = ["--日",
//            " 1日"," 2日"," 3日"," 4日"," 5日"," 6日"," 7日"," 8日"," 9日","10日",
//            "11日","12日","13日","14日","15日","16日","17日","18日","19日","20日",
//            "21日","22日","23日","24日","25日","26日","27日","28日","29日","30日","31日"]
//    
//    BHour = ["--",
//             " 0"," 1"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9",
//             "10","11","12","13","14","15","16","17","18","19",
//             "20","21","22","23"]
//    
//    for _ in 1..<100
//    {
//        BMin += ["00","01","02","03","04","05","06","07","08","09",
//                 "10","11","12","13","14","15","16","17","18","19",
//                 "20","21","22","23","24","25","26","27","28","29",
//                 "30","31","32","33","34","35","36","37","38","39",
//                 "40","41","42","43","44","45","46","47","48","49",
//                 "50","51","52","53","54","55","56","57","58","59"]
//    }
//    
//    BAll = [BYearMonth,BDay,BHour,BMin]
//}
