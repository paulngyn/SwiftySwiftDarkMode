//
//  AppSplitViewController.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import UIKit

// Connect this if you have a SplitViewController
class AppSplitViewController: UISplitViewController{
    
    private var statusBarMode: UIStatusBarStyle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarMode ?? super.preferredStatusBarStyle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
}

extension AppSplitViewController: ModeType {
    func applyMode(_ mode: AppMode) {
        self.statusBarMode = mode.statusBarStyle
        self.setNeedsStatusBarAppearanceUpdate()
        print("change nav control mode")
    }
}
