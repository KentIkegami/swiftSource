//
//  ViewController.swift
//  openCV
//
//  Created by inf on 2018/06/01.
//  Copyright © 2018年 kent. All rights reserved.
//


//https://qiita.com/fushikky/items/e53fab1a48d43ff94006
//https://qiita.com/tomoyuki_HAYAKAWA/items/1e214b21725f45269807


import UIKit

class ToGrayViewController: UIViewController {
    let openCV = OpenCVWrapper()
    
    let imgViewPre = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    let imgViewPost = UIImageView(frame: CGRect(x: 100, y: 250, width: 100, height: 100))
    var sampleImg = UIImage(named: "a.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //変換前画像
        imgViewPre.image = sampleImg
        imgViewPre.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.view.addSubview(imgViewPre)
        //変更後画像
        imgViewPost.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.view.addSubview(imgViewPost)
        
        let button = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 40) )
        button.backgroundColor = UIColor.brown
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.showsTouchWhenHighlighted = true
        button.setTitle(NSLocalizedString("Go!", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(self.tap(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc
    func tap(sender:Any) {
        
        let imgGray = openCV.toGray(sampleImg)
        imgViewPost.image = imgGray
    }

}

