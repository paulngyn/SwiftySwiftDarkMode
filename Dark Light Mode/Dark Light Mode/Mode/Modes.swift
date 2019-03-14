//
//  Modes.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import Foundation

// Describes a type holding a current `Mode` and allows an object to be notified when the mode is changed.
protocol ModeConfig {
    
    associatedtype Mode // Placeholder for the mode that app will use
    
    var currentMode: Mode { get } // Current mode active
    
    func subscribeToChanges(_ object: AnyObject, handler: @escaping (Mode) -> Void) // Subscribe function notifies when mode changes. Handler is removed from subscription when `object` is deallocated.
}

// Describes a type that can have a mode applied to it
protocol ModeType {
    
    associatedtype _ModeConfig: ModeConfig // ModeType needs to know what type the ModeConfig is. To avoid clashing protocol, we make associated type _ModeConfig
    
    var modeConfig: _ModeConfig { get } // Return the current app-wide mode provider
    
    func applyMode(_ mode: _ModeConfig.Mode) // Is called when mode changes
}

extension ModeType where Self: AnyObject {
    // Called once when Self wants to start detecting mode changes. Immediately triggers setUpMode() with the current mode.
    func setUpMode() {
        applyMode(modeConfig.currentMode)
        modeConfig.subscribeToChanges(self) { [weak self] newMode in
            self?.applyMode(newMode)
        }
    }
}
