//
//  ViewController.swift
//  openCV
//
//  Created by inf on 2018/06/01.
//  Copyright © 2018年 kent. All rights reserved.
//


//http://www.bravesoft.co.jp/blog/archives/2265


import UIKit
import Accelerate
import AssetsLibrary
import AVFoundation
import CoreGraphics
import CoreImage
import CoreMedia
import CoreVideo
import QuartzCore
import Foundation

class CameraViewController: UIViewController {
    let openCV = OpenCVWrapper()
    

    let imgViewPost = UIImageView(frame: CGRect(x: 100, y: 250, width: 100, height: 100))

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //カメラスタート
        openCV.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        let imgViewPost = UIImageView(frame: CGRect(x: 0, y: 70, width: 480, height: 640))

        
        //変更後画像
        imgViewPost.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.view.addSubview(imgViewPost)
        //カメラViewの作成
        openCV.createCamera(withParentView: imgViewPost)
        
    }
    
  
}

