//
//  SubscriberValue.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import Foundation

// Stores value of type T, allows objects to subscribe and be notified with this value if changed.
struct subscribableValue<T> {
    private typealias Subscription = (object: Weak<AnyObject>, handler: (T) -> Void)
    
    private var subscriptions: [Subscription] = []
    
    var value: T {
        didSet {
            for (object, handler) in subscriptions where object.value != nil {
                handler(value)
            }
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    mutating func subscribe(_ object: AnyObject, using handler: @escaping (T) -> Void) {
        subscriptions.append((Weak(value: object), handler))
        cleanupSubscriptions()
    }
    
    // Removes any subscriptions where object has deallocated and no longer exists
    private mutating func cleanupSubscriptions() {
        subscriptions = subscriptions.filter({ entry in
            return entry.object.value != nil
        })
    }
}
