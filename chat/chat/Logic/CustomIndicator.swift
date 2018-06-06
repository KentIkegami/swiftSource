//  Copyright © 2017年 池上けんと. All rights reserved.
import UIKit

class CustomIndicator
{
    var indicator:UIActivityIndicatorView!
    var wall:UIView!
    var px:CGFloat = UIScreen.main.bounds.size.width/2
    var py:CGFloat = UIScreen.main.bounds.size.height/2
    
    func createIndicator() -> UIActivityIndicatorView
    {
        indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x:0, y:0, width:50, height:50)
        indicator.center =  CGPoint(x: px, y: py)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.stopAnimating()
        
        return indicator
    }
    
    func createWall() -> UIView
    {
        wall = UIView()
        wall.frame = .zero
        wall.backgroundColor = UIColor.hex("#000000", alpha: 0.3)
        return wall
    }
}


