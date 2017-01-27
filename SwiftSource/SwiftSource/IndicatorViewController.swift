
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.

import UIKit

class IndicatorViewController: UIViewController
{
    var indicator:UIActivityIndicatorView!
    var wall:UIView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Indicator"
        
        let makeButtonInstance = CustomButton()
        let aButton = makeButtonInstance.createButton(px: UIScreen.main.bounds.size.width*3/4,
                                                      py: 10,
                                                      st: "Indicator",
                                                      ct: "memo",
                                                      tag: 0)
        aButton.addTarget(self, action:  #selector(onTap(sender:)), for: .touchUpInside)
        
        //rightaddbutton
        let rightButton = UIBarButtonItem(image: UIImage(named: "ic_menu_add"),
                                          style: UIBarButtonItemStyle.plain,
                                          target: self,
                                          action: #selector(switchIndicator(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func switchIndicator(sender:UIButton)
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
