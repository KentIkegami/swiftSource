//
//  ViewController.swift
//  decibel
//
//  Created by inf on 2018/08/30.
//  Copyright © 2018年 kent. All rights reserved.
//

import UIKit
import SideMenu
import FontAwesome_swift

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        //menu
        let menuViewController = MenuViewController()
        menuViewController.parentView = self //親ビューの設定
        //サイドメニューのプロパティ設定
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuViewController)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        //LeftMenuボタン
        let menuButton = UIBarButtonItem(title: String.fontAwesomeIcon(name: .meh), style: .done,  target: self, action: #selector(self.buttonTapped(sender:)))
        menuButton.isEnabled = true
        menuButton.setTitleTextAttributes(NSDictionary(dictionary: [NSAttributedStringKey.font:UIFont.fontAwesome(ofSize: 25, style: .regular),
                                                                                 NSAttributedStringKey.foregroundColor : UIColor.hex(COLOR.MAIN, alpha: 1)]) as? [NSAttributedStringKey : Any] ,for: UIControlState.normal)
        self.navigationItem.setLeftBarButton(menuButton, animated: true)
        
    }
    
    //Leftメニューボタンアクション
    @objc func buttonTapped(sender : AnyObject) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
}

