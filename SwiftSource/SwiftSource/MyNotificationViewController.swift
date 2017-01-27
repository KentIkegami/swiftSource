
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class MyNotificationViewController: UIViewController
    
{
    
    let notificationName = Notification.Name("formNotificationIdentifier")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "MyNotification"
        
        
        
        //notification
        //NotificationCenter.default.addObserver(self, selector: #selector(MyNotification.test(notification:)), name: notificationName, object: nil)
        
        
        let makeButtonInstance = CustomButton()
        //あああ
        let aButton = makeButtonInstance.createButton(px: UIScreen.main.bounds.size.width/4,
                                                    py: 200,
                                                    st: "yahoo",
                                                    ct: "memo",
                                                    tag: 0)
        aButton.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        self.view.addSubview(aButton)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func onTap(sender: UIButton)
    {
        print("ssss")
    }
    
}
