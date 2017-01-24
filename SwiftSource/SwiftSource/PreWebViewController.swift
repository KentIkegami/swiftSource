
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

//HTTP通信はできない　例外リストを作る必要あり　http://nlogic.jp/?p=412
//App Transport Security Settings に　Allow Arbitrary Loads　でYES で暫定許可


import UIKit

class PreWebViewController: UIViewController
{
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "PreWebView"
    
        let makeButtonInstance = MakeButtonLogic()
        //あああ
        let aButton = makeButtonInstance.makeButton(px: UIScreen.main.bounds.size.width/4,
                                      py: 200,
                                      st: "yahoo",
                                      ct: "memo",
                                      tag: 0)
        aButton.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        self.view.addSubview(aButton)
        
        //いいい
        let bButton = makeButtonInstance.makeButton(px: UIScreen.main.bounds.size.width/4,
                                                    py: 300,
                                                    st: "google",
                                                    ct: "memo",
                                                    tag: 1)
        bButton.addTarget(self, action:  #selector(onTap(sender:)), for: .touchDown)
        self.view.addSubview(bButton)
        
        //ううう
        let cButton = makeButtonInstance.makeButton(px: UIScreen.main.bounds.size.width/4,
                                                    py: 400,
                                                    st: "infoseek",
                                                    ct: "memo",
                                                    tag: 2)
        cButton.addTarget(self, action:  #selector(onTap(sender:)), for: .touchDown)
        self.view.addSubview(cButton)

    }
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
     func onTap(sender: UIButton){
        
        let webView = WebViewController()
        
        switch sender.tag {
        case 0:
            webView.title = "yahoo"
            webView.urlStr = "http://infinityloop.co.jp/test/sk/credit.html"
        case 1:
            webView.title = "google"
            webView.urlStr = "https://www.google.co.jp/"
        case 2:
            webView.title = "infoseek"
            webView.urlStr = "http://infinityloop.co.jp/test/sk/credit.html"
        default:
            webView.title = "404"
        }
        
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
}

