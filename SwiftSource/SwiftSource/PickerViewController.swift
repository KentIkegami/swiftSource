
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.


import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate{
    
    private var myPickerBaseView:UIView!
    private var myPicker: UIPickerView!
    private var myTextField = UITextField()
    private var pickerValues: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "PickerView"
        
        myPickerBaseView = makePickerBaseView()
        self.view.addSubview(myPickerBaseView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makePickerBaseView() -> UIView
    {
        //配列の初期化
        for _ in 1..<100
        {
            pickerValues += [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
        }
        
        //パーツを乗せるビュー
        let baseView = UIView()
        baseView.backgroundColor = UIColor.cyan
        baseView.frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        baseView.layer.position = CGPoint(x: CGFloat(UIScreen.main.bounds.size.width)/2,
                                          y: CGFloat(UIScreen.main.bounds.size.height)/2)
        baseView.layer.cornerRadius = 5
    
        //文字
        let ji:UILabel = UILabel()
        ji.frame = CGRect(x: 70,
                          y: 1,
                          width: CGFloat(UIScreen.main.bounds.size.width)*0.7,
                          height: 48)
        ji.text = "時間"
        baseView.addSubview(ji)
        
        //baseViewにテキストフィールドを乗せる
        var myTextField = UITextField()
        myTextField = makeTextField()
        baseView.addSubview(myTextField)
        myTextField.text = "1"

        return baseView
    }
    
    func makeTextField() -> UITextField
    {
        myTextField = UITextField(frame: CGRect(x: 0, y: 0, width:40, height: 40))
        myTextField.layer.position = CGPoint(x: 40, y: 25)
        myTextField.delegate = self
        myTextField.layer.cornerRadius = 5.0
        myTextField.layer.borderWidth = 1.5
        myTextField.layer.borderColor = UIColor.cyan.cgColor
        myTextField.font = UIFont.systemFont(ofSize: CGFloat(20))
        myTextField.textColor = UIColor.black
        myTextField.backgroundColor = UIColor.white
        myTextField.tintColor = UIColor.clear //キャレット(カーソル)を消す。
        myTextField.inputView = makePicker()  //ここでピッカービューをセットする。
        myTextField.text = "1"
        myTextField.textAlignment = .center
        return myTextField
    }
    
    //入力領域を引っ込める
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myTextField.endEditing(true)
    }
    
    //ピッカービューの作成
    func makePicker() -> UIPickerView
    {
        myPicker = UIPickerView()
        myPicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200.0)
        myPicker.layer.position = CGPoint(x:0, y:0)
        myPicker.backgroundColor = UIColor.cyan
        myPicker.delegate = self
        myPicker.dataSource = self
        //初期選択位置の設定
        myPicker.selectRow(24*50, inComponent: 0, animated: true)
        return myPicker
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //pickerに表示する行数を返すデータソースメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    //pickerに表示する値を返すデリゲートメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: pickerValues[row])
    }
    
    //pickerが選択時デリゲートメソッド
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row) , value: \(pickerValues[row])")
        //テキストビューの値変更
        myTextField.text = "\(pickerValues[row])"
    }
}


