//
//  AppModesConfig.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import UIKit

final class AppModeConfig: ModeConfig {
    static let shared: AppModeConfig = .init()
    
    private var mode: subscribableValue<AppMode>
    private var availableModes: [AppMode] = [.light, .dark, .zen]
    
    var currentMode: AppMode {
        get {
            return mode.value
        }
        set {
            setNewMode(newValue)
        }
    }
    
    init() {
        mode = subscribableValue<AppMode>(value: .light)
    }
    
    private func setNewMode(_ newMode: AppMode) {
        let window = UIApplication.shared.delegate!.window!!
        UIView.transition(
            with: window,
            duration: 0.1,
            options: [.transitionCrossDissolve],
            animations: {
                self.mode.value = newMode
        },
            completion: nil
        )
    }
    
    func subscribeToChanges(_ object: AnyObject, handler: @escaping (AppMode) -> Void) {
        mode.subscribe(object, using: handler)
    }
    
    func nextMode() {
        guard let nextMode = availableModes.rotate() else {
            return
        }
        currentMode = nextMode
    }
}

extension ModeType where Self: AnyObject {
    var modeConfig: AppModeConfig {
        return AppModeConfig.shared
    }
}
