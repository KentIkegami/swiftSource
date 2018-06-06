//
//  CameraViewController.swift
//  Tech X mobile
//
//  Created by kent on 2017/12/10.
//  Copyright © 2017年 inf. All rights reserved.
//

import UIKit
import AVFoundation

class VideoViewController:UIViewController,
    AVCaptureVideoDataOutputSampleBufferDelegate,
    UITableViewDelegate,
    UITableViewDataSource
{
    private var input:AVCaptureDeviceInput!
    private var output:AVCaptureVideoDataOutput!
    private var session:AVCaptureSession!
    private var camera:AVCaptureDevice!
    private var imageView:UIImageView!
    private var _tableView: UITableView!
    
    //連続シャッター onoff
    var timer: Timer!
    private var isContinuity = false
    
    //表示用
    var markers:[Marker] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //ナビコンを消す
        //navigationController?.setNavigationBarHidden(true, animated: false)
        // スクリーン設定
        setupDisplay()
        // カメラの設定
        setupCamera()
    }
    override func viewDidAppear(_ animated: Bool) {
        togglePosting()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        togglePosting()
        // camera stop メモリ解放
        session.stopRunning()
        
        for output in session.outputs {
            session.removeOutput(output)
        }
        
        for input in session.inputs {
            session.removeInput(input)
        }
        session = nil
        camera = nil


    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    /*-------------------------------------------------------------------------
     カメラビュー
     -------------------------------------------------------------------------*/
    func setupDisplay(){
        // プレビュー用のビューを生成
        //スクリーンの幅
        let screenWidth = UIScreen.main.bounds.size.width;
        //スクリーンの高さ
        let screenHeight = UIScreen.main.bounds.size.height;
        
        // プレビュー用のビューを生成
        imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        
        var topPadding:CGFloat = 0
        //var bottomPadding:CGFloat = 0
        var leftPadding:CGFloat = 0
        var rightPadding:CGFloat = 0
        
        // iPhone X , X以外は0となる
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window!.safeAreaInsets.top
            //bottomPadding = window!.safeAreaInsets.bottom
            leftPadding = window!.safeAreaInsets.left
            rightPadding = window!.safeAreaInsets.right
        }
        
        // portrait
        let safeAreaWidth = screenWidth - leftPadding - rightPadding
        //let safeAreaHeight = (screenHeight) - topPadding - bottomPadding
        
        // カメラ画像サイズはsessionPresetによって変わる
        // とりあえず16:9のportraitとして設定
        let rect = CGRect(x: leftPadding, y: topPadding,
                          width: safeAreaWidth, height: safeAreaWidth/9*16)
        
        // frame をCGRectで作った矩形に合わせる
        imageView.frame = rect
        imageView.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
    }
    
    func setupCamera(){
        // セッション
        session = AVCaptureSession()
        
        // 背面・前面カメラの選択
        camera = AVCaptureDevice.default(
            AVCaptureDevice.DeviceType.builtInWideAngleCamera,
            for: AVMediaType.video,
            position: .back) // position: .front
        
        // カメラからの入力データ
        do {
            input = try AVCaptureDeviceInput(device: camera)
            
        } catch let error as NSError {
            print(error)
        }
        
        // 入力をセッションに追加
        if(session.canAddInput(input)) {
            session.addInput(input)
        }
        
        // 静止画出力のインスタンス生成
        output = AVCaptureVideoDataOutput()
        
        // 出力をセッションに追加
        if(session.canAddOutput(output)) {
            session.addOutput(output)
        }
        // ピクセルフォーマットを 32bit BGR + A とする
        output.videoSettings =
            [kCVPixelBufferPixelFormatTypeKey as AnyHashable as!
                String : Int(kCVPixelFormatType_32BGRA)]
        
        // フレームをキャプチャするためのサブスレッド用のシリアルキューを用意
        output.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        output.alwaysDiscardsLateVideoFrames = true
        
        self.imageView.addSubview(createFrame(insideWidth: UIScreen.main.bounds.size.width * 1/1))//撮影外領域
        //self.imageView.addSubview(createShutterButton())//シャッターボタン
        //テーブルビューの作成
        self.tabelViewSet()
        self.imageView.addSubview(createBackButton())//戻るボタン
        self.imageView.addSubview(createFrameInside())//撮影領域
        session.startRunning()
    }
    
    // 新しいキャプチャの追加で呼ばれる
    func captureOutput(_ captureOutput: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        // キャプチャしたsampleBufferからUIImageを作成
        let image:UIImage = self.captureImage(sampleBuffer)
        
        // 画像を画面に表示
        DispatchQueue.main.async {
            self.imageView.image = image
            
            // UIImageViewをビューに追加
            self.view.addSubview(self.imageView)
        }
    }
    // sampleBufferからUIImageを作成
    func captureImage(_ sampleBuffer:CMSampleBuffer) -> UIImage{
        
        // Sampling Bufferから画像を取得
        let imageBuffer:CVImageBuffer =
            CMSampleBufferGetImageBuffer(sampleBuffer)!
        
        // pixel buffer のベースアドレスをロック
        CVPixelBufferLockBaseAddress(imageBuffer,
                                     CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
        
        let baseAddress:UnsafeMutableRawPointer =
            CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)!
        
        let bytesPerRow:Int = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width:Int = CVPixelBufferGetWidth(imageBuffer)
        let height:Int = CVPixelBufferGetHeight(imageBuffer)
        
        
        // 色空間
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        //let bitsPerCompornent:Int = 8
        // swift 2.0
        let newContext:CGContext = CGContext(data: baseAddress,
                                             width: width, height: height, bitsPerComponent: 8,
                                             bytesPerRow: bytesPerRow, space: colorSpace,
                                             bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue|CGBitmapInfo.byteOrder32Little.rawValue)!
        
        let imageRef:CGImage = newContext.makeImage()!
        let resultImage = UIImage(cgImage: imageRef,
                                  scale: 1.0, orientation: UIImageOrientation.right)
        
        return resultImage
    }
    
    
    /*-------------------------------------------------------------------------
     シャッター
     -------------------------------------------------------------------------*/
    //シャッターボタン作成
    func createShutterButton()->UILabel{
        let shutterLabel = UILabel(frame:CGRect(x: 0,
                                                y: 0,
                                                width: CGFloat(UIScreen.main.bounds.size.width) * 1/6,
                                                height: CGFloat(UIScreen.main.bounds.size.width) * 1/6))
        shutterLabel.layer.position = CGPoint(x: UIScreen.main.bounds.size.width * 1/2,
                                              y: CGFloat(UIScreen.main.bounds.size.height) * 10/12)
        shutterLabel.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let imageView = UIImageView(image:UIImage(named: "camera.png"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: CGFloat(UIScreen.main.bounds.size.width) * 1/8, height: CGFloat(UIScreen.main.bounds.size.width) * 1/8)
        imageView.layer.position = CGPoint(x: CGFloat(UIScreen.main.bounds.size.width) * 1/12, y: CGFloat(UIScreen.main.bounds.size.width) * 1/12 - 3)
        imageView.tintColor = UIColor.white
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        shutterLabel.addSubview(imageView)
        shutterLabel.textColor = UIColor.white
        shutterLabel.textAlignment = .center
        shutterLabel.layer.masksToBounds = true
        shutterLabel.layer.cornerRadius =  CGFloat(UIScreen.main.bounds.size.width) * 1/12
        shutterLabel.backgroundColor = UIColor.blue
        shutterLabel.isUserInteractionEnabled = true//アクション追加
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(self.tapped(_:)))
        shutterLabel.addGestureRecognizer(tapGesture)
        return shutterLabel
    }
    @objc func tapped(_ sender: UITapGestureRecognizer){
        togglePosting()
    }
    func togglePosting(){
        if self.isContinuity{
            //stop
            timer.invalidate()
            timer = nil
            self.isContinuity = false
        }else{
            //start
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            timer.fire()
            
            self.isContinuity = true
        }
    }
    // クーロン
    @objc func update(tm: Timer) {
        takeStillPicture()
        
    }
    //カメラから画像取得
    func takeStillPicture(){
        
        if var _:AVCaptureConnection =
            output.connection(with: AVMediaType.video){
            
            var photo = self.imageView.image!

            //画像を何かしらの処理に回す
            //getCollections(photo)
        }
    }
    


    func customAlert(msg:String){
        //その他エラーアラート
        let yesAlertController = UIAlertController(title: "システムからのお知らせ",
                                                   message: msg,
                                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "閉じる",
                                     style: .cancel,
                                     handler: nil)
        yesAlertController.addAction(okAction)
        self.present(yesAlertController, animated: true, completion: nil)
    }
    /*-------------------------------------------------------------------------
     tabelView
     -------------------------------------------------------------------------*/
    func tabelViewSet(){
        if _tableView == nil{
            // TableView
            _tableView = UITableView(frame: CGRect(x: 0,
                                                   y: UIScreen.main.bounds.size.width,
                                                   width: UIScreen.main.bounds.size.width,
                                                   height: (CGFloat(UIScreen.main.bounds.size.height)-UIScreen.main.bounds.size.width)))
            
            _tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: "ArticleCell")
            _tableView.dataSource = self//データソースの設定
            _tableView.delegate = self
            _tableView.tableFooterView = UIView(frame: .zero)
            _tableView.rowHeight = 50
            _tableView.backgroundColor = UIColor.clear
            self.imageView.addSubview(_tableView)
            
        }else{
            self._tableView.reloadData()
        }
    }
    /*Cellの総数を返す*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.markers.count
    }
    /*Cellに値を設定する*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell: UITableViewCell? // nilになることがあるので、Optionalで宣言
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "ArticleCell")
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell",for: indexPath as IndexPath)// 再利用するCellを取得する.
        }
        cell?.accessoryType = .none //右側の
        cell?.textLabel!.text = self.markers[indexPath.row].name
        cell?.detailTextLabel?.text = self.markers[indexPath.row].name
        cell?.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return cell!
    }
    
    /*Cellが選択された際に呼び出される*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //
        print("piyo")
        
    }
    /*-------------------------------------------------------------------------
     Other
     -------------------------------------------------------------------------*/
    //撮影領域
    func createFrameInside()->UILabel
    {
        let label = UILabel()
        let newWidth = CGFloat(UIScreen.main.bounds.size.width * 1/1)
        let newHeight = CGFloat(UIScreen.main.bounds.size.width * 1/1)
        let x = (CGFloat(UIScreen.main.bounds.size.width) - newWidth)/2
        let y = CGFloat(0)//(CGFloat(UIScreen.main.bounds.size.height) - newHeight)/2
        label.frame = CGRect(x: x, y: y, width: newWidth, height: newHeight)
        //label.backgroundColor = UIColor.hex("#00ff13", alpha: 0.1)
        return label
    }
    
    //撮影外領域
    func createFrame(insideWidth:CGFloat)->UILabel
    {
        let outsideWidth = CGFloat(UIScreen.main.bounds.size.width)
        let color = UIColor.black.withAlphaComponent(0.4)
        let label = UILabel()
        label.frame = CGRect(x: 0,
                             y: 0,
                             width: CGFloat(UIScreen.main.bounds.size.width),
                             height: CGFloat(UIScreen.main.bounds.size.height))

        //下
        let bottom = UILabel(frame: CGRect(x: (outsideWidth-insideWidth)*1/2,
                                           y: insideWidth,
                                           width: insideWidth,
                                           height: (CGFloat(UIScreen.main.bounds.size.height)-insideWidth)))
        bottom.backgroundColor = color
        label.addSubview(bottom)
        
        return label
    }
    //戻るボタン
    func createBackButton()->UILabel
    {
        let backLabel = UILabel(frame:CGRect(x: 5,
                                             y: CGFloat(UIScreen.main.bounds.size.height) * 10.5/12,
                                             width: CGFloat(UIScreen.main.bounds.size.width) * 1/8,
                                             height: CGFloat(UIScreen.main.bounds.size.width) * 1/8))
        backLabel.layer.anchorPoint = CGPoint(x: 0, y: 0)
        backLabel.text = "<<"
        backLabel.textColor = UIColor.black
        backLabel.textAlignment = .center
        backLabel.layer.masksToBounds = true
        backLabel.layer.cornerRadius =  CGFloat(UIScreen.main.bounds.size.width) * 1/16
        backLabel.backgroundColor = UIColor.orange
        backLabel.isUserInteractionEnabled = true//アクション追加
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(self.tapBack(_:)))
        backLabel.addGestureRecognizer(tapGesture)
        
        return backLabel
    }
    @objc func tapBack(_ sender: UILongPressGestureRecognizer){
        navigationController?.popViewController(animated: true)
    }
    
    /*-------------------------------------------------------------------------
     Other Methods
     -------------------------------------------------------------------------*/
    
}


