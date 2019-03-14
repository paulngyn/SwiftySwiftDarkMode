//
//  WeakHold.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import Foundation

// A structure that can hold on to an object
struct Weak<Object: AnyObject> {
    weak var value: Object?
}
