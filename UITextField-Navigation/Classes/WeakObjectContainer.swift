//
//  WeakObjectContainer.swift
//  Pods
//
//  Created by Thanh Pham on 6/27/16.
//
//

class WeakObjectContainer {
    weak var object: AnyObject?

    init(object anObject: AnyObject?) {
        object = anObject
    }
}
