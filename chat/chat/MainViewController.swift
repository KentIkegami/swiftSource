//
//  ViewController.swift
//  chat
//
//  Created by kent on 2017/10/28.
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextViewDelegate,BTPeripheralDelegate {

    //memoTextView
    private var memoTextView = UITextView()
    //ペリフェラル
    var peripheral: BTPeripheral! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画面サイズ取得
        let Sc_w = UIScreen.main.bounds.size.width
        let Sc_h = UIScreen.main.bounds.size.height
        //背景色とnavi使用時のタイトル
        self.view.backgroundColor = UIColor.hex(ColorAll.COLOR_BASE, alpha: 1)
        self.title = NSLocalizedString("Top", comment: "")
        //ナビゲーションバーコントロール
        if let nv = navigationController {
            nv.setNavigationBarHidden(true, animated: true)
        }
        //ペリフェラル初期化
        peripheral = BTPeripheral(delegate: self)
        
        //入力
        let customField = CustomTextView()
        customField.w = Sc_w*0.9
        customField.h = Sc_h*0.13
        memoTextView = customField.createTextView(px: Sc_w*1/2, py: Sc_h*1/11, st: "", ct: "", tag: 5)
        memoTextView.textAlignment = .left
        memoTextView.font = UIFont.systemFont(ofSize:20)
        memoTextView.delegate = self
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 20
        paragraphStyle.headIndent = 20
        paragraphStyle.tailIndent = 0
        paragraphStyle.alignment = NSTextAlignment.left
        
        let attributedText = NSMutableAttributedString(string:memoTextView.text)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle,
                                    value:paragraphStyle,
                                    range: NSMakeRange(0, attributedText.length))
        
        memoTextView.attributedText = attributedText
        self.view.addSubview(memoTextView)

        
        //ボタン　確認
        let customButtonBack = CustomButton()
        customButtonBack.w = UIScreen.main.bounds.size.width*0.40
        let button = customButtonBack.createButton(px: UIScreen.main.bounds.size.width*3/4,
                                                   py: UIScreen.main.bounds.size.height*3/11,
                                                   st: "Confirm",
                                                   ct: "確認",
                                                   tag: 0)
        button.addTarget(self,
                         action:  #selector(onTapConfirm(sender:)),
                         for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc
    func onTapConfirm(sender: UIButton){
        let _memo = memoTextView.text!
        print(_memo)
        sentMsg(msg:_memo)
    }

    public func sentMsg(msg:String){
        peripheral.startAdvertising()
        
    }
    func message(s: String) {
        print(s)
    }
    
    func debug(s: String) {
        print(s)
    }


}

