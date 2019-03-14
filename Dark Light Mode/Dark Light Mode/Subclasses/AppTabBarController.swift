//
//  AppTabBarController.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import UIKit

// Connect this class if you have a UITabBarController
class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMode()
    }
}

extension AppTabBarController: ModeType {
    func applyMode(_ mode: AppMode) {
        tabBar.barTintColor = mode.barBackgroundColor
        tabBar.tintColor = mode.barForegroundColor
    }
}
