
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class PickerViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate
{
    
    private var APickerBaseView:UIView!
    private var APicker: UIPickerView!
    private var ATextField = UITextField()
    private var AYearMonth: [String] = []
    private var ADay: [String] = []
    private var AHour: [String] = []
    private var AMin: [String] = []
    private var AAll: [[String]]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "PickerView2"
        
        APickerBaseView = AmakePickerBaseView()
        self.view.addSubview(APickerBaseView)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func AmakePickerBaseView() -> UIView
    {
        //配列の初期化
        AYearMonth = ["----年--月","2017年 1月","2017年 2月","2017年 3月","2017年 4月","2017年 5月",
                      "2017年 6月","2017年 7月","2017年 8月","2017年 9月","2017年10月","2017年11月","2017年12月"]
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
        
        //パーツを乗せるビュー
        let baseView = UIView()
        baseView.backgroundColor = UIColor.cyan
        baseView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width*0.9, height: 50)
        baseView.layer.position = CGPoint(x: CGFloat(UIScreen.main.bounds.size.width)/2,
                                          y: CGFloat(UIScreen.main.bounds.size.height)/2)
        baseView.layer.cornerRadius = 5
        
        //文字
        let ji:UILabel = UILabel()
        ji.frame = CGRect(x: 10,
                          y: 1,
                          width: CGFloat(UIScreen.main.bounds.size.width)*0.1,
                          height: 48)
        ji.text = "start"
        baseView.addSubview(ji)
        
        //baseViewにテキストフィールドを乗せる
        var ATextField = UITextField()
        ATextField = makeTextField()
        baseView.addSubview(ATextField)
        ATextField.text = "2017年 1月 23日 14:22"
        
        return baseView
    }
    
    func makeTextField() -> UITextField
    {
        ATextField = UITextField(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width*0.7, height: 40))
        ATextField.layer.position = CGPoint(x: UIScreen.main.bounds.size.width*0.50, y: 25)
        ATextField.delegate = self
        ATextField.layer.cornerRadius = 5.0
        ATextField.layer.borderWidth = 1.5
        ATextField.layer.borderColor = UIColor.cyan.cgColor
        ATextField.font = UIFont.systemFont(ofSize: CGFloat(20))
        ATextField.textColor = UIColor.black
        ATextField.backgroundColor = UIColor.white
        ATextField.tintColor = UIColor.clear //キャレット(カーソル)を消す。
        ATextField.inputView = makePicker()  //ここでピッカービューをセットする。
        ATextField.text = "----年 --月 --日 --:00"
        ATextField.textAlignment = .center
        return ATextField
    }
    
    //入力領域を引っ込める
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        ATextField.endEditing(true)
    }
    
    //ピッカービューの作成
    func makePicker() -> UIPickerView
    {
        APicker = UIPickerView()
        APicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200.0)
        APicker.layer.position = CGPoint(x:0, y:0)
        APicker.backgroundColor = UIColor.cyan
        APicker.delegate = self
        APicker.dataSource = self
        //初期選択位置の設定
        APicker.selectRow(60*50, inComponent: 3, animated: true)
        return APicker
    }
    
    //ホイールの幅
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return AAll.count
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
        return AAll[component].count
    }
    
    //pickerに表示する値を返すデリゲートメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return AAll[component][row]
    }
    
    //データを返すメソッド
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.text = AAll[component][row]
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
        
        let _AYearMonth = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!
        let _ADay = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!
        let _AHour = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 2), forComponent: 2)!
        let _AMin = self.pickerView(APicker, titleForRow: pickerView.selectedRow(inComponent: 3), forComponent: 3)!
        
        //テキストビューの値変更
        ATextField.text = "\(_AYearMonth) \(_ADay)　\(_AHour):\(_AMin)"
        print("\(_AYearMonth),\(_ADay),\(_AHour),\(_AMin)")
    }
}


