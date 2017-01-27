
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class TextViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Text"
        
        let MakeLabelLogicInstance = CustomLabel()
        let label = MakeLabelLogicInstance.createLabel(px: 100, py: 100, st: "aaaaaaaa aaaaa aaaaaa aa", ct: "aa", tag: 0)
        self.view.addSubview(label)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
