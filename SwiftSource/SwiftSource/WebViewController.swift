
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate 
{
    
    
    var urlStr:String = "http://kabusiki.dd3.biz/jihou.html"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        //webview
        let myWebView : UIWebView = UIWebView()
        myWebView.delegate = self
        myWebView.frame = self.view.bounds
        self.view.addSubview(myWebView)
        
        let url: URL = URL(string: urlStr)!
        let request: URLRequest = URLRequest(url: url)
        myWebView.loadRequest(request)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
