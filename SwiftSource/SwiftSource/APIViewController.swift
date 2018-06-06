
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class APIViewController: UIViewController
{
    
    //インジケーターロジック　1/3
    var indicator:UIActivityIndicatorView!
    var wall:UIView!
    
    
    var imageView:UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "API"
        
        //API呼び出しButton
        let makeButtonInstance = CustomButton()
        let aButton = makeButtonInstance.createButton(px: UIScreen.main.bounds.size.width/4,py: 200,st: "yahoo",ct: "memo",tag: 0)
        aButton.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        self.view.addSubview(aButton)
        
        //インジケーターロジック　2/3
        let customIndicator = CustomIndicator()
        indicator = customIndicator.createIndicator()
        self.view.addSubview(indicator)
        wall = customIndicator.createWall()
        self.view.addSubview(wall)
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //オンタップイベント
    @objc func onTap(sender:UIButton)
    {
        //インジケーターオン
        switchIndicator()
        
        //apiにPOST
        let api = APIManager()
        api.loginApi { (_result) in
            print(_result)
            //インジーケーターオフ
            self.switchIndicator()
        }
        
    }
    
    

    
    
    
    //インジケーターロジック3/3
    //インジケーターの表示、非表示
    func switchIndicator()
    {
        if (self.indicator == nil)
        {
            let customIndicator = CustomIndicator()
            //ユーザー操作を制限するレイヤーの追加
            wall = customIndicator.createWall()
            self.view.addSubview(wall)
            //インジケーターの追加
            indicator = customIndicator.createIndicator()
            self.view.addSubview(indicator)
        }
        
        if indicator.isAnimating
        {
            wall.frame = .zero
            indicator.stopAnimating()
        }
        else
        {
            wall.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height)
            indicator.startAnimating()
        }
    }
    
}



/*------------------------------------------*/
/*------------------------------------------*/
/*------------------------------------------*/


class APIManager
{
    
    func loginApi(callback:@escaping (String) -> Void)
    {
        //遅延処理3秒
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            print("wわわわわあ")
            let result:String = "success"
            callback(result)
            
        
            })
        
    }


}















