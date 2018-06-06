//
//  MyNavigationController.swift
//  magic
//
//  Created by kent on 2017/05/06.
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.visibleViewController;
    }
}

