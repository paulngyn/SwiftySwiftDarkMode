//
//  AppThemes.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import UIKit

struct AppMode {
    var statusBarStyle: UIStatusBarStyle
    var barBackgroundColor: UIColor
    var barForegroundColor: UIColor
    var backgroundColor: UIColor
    var textColor: UIColor
}

extension AppMode {
    static let light = AppMode(
        statusBarStyle: UIStatusBarStyle.default,
        barBackgroundColor: .white,
        barForegroundColor: .black,
        backgroundColor: UIColor(white: 0.9, alpha: 1),
        textColor: .darkText
    )
    
    static let dark = AppMode(
        statusBarStyle: UIStatusBarStyle.lightContent,
        barBackgroundColor: UIColor(white: 0, alpha: 1),
        barForegroundColor: UIColor(red: 252/255, green: 95/255, blue: 163/255, alpha: 1),
        backgroundColor: UIColor(white: 0.2, alpha: 1),
        textColor: UIColor(red: 153/255, green: 233/255, blue: 215/255, alpha: 1)
    )
    
    static let zen = AppMode(
        statusBarStyle: UIStatusBarStyle.lightContent,
        barBackgroundColor: UIColor(red: 252/255, green: 49/255, blue: 89/255, alpha: 1),
        barForegroundColor: .white,
        backgroundColor: .white,
        textColor: UIColor(red: 84/255, green: 237/255, blue: 161/255, alpha: 1)
    )
}
