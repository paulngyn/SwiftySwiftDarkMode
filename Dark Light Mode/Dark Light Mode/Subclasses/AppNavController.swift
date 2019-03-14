//
//  AppNavController.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import UIKit

// Connect this class if you have a NavigationController
class AppNavController: UINavigationController, UINavigationBarDelegate, UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
}

extension AppNavController: ModeType {
    func applyMode(_ mode: AppMode) {
        navigationBar.barTintColor = mode.barBackgroundColor
        navigationBar.tintColor = mode.barForegroundColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: mode.barForegroundColor
        ]
    }
}
