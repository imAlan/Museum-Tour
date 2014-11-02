//
//  singleton.swift
//  Museum Tour
//
//  Created by Alan Chen on 11/1/14.
//  Copyright (c) 2014 Urban Games. All rights reserved.
//

import Foundation

class singleton{
    class var sharedInstance :singleton{
        struct Singleton {
            static let instance = singleton()
        }
        return Singleton.instance
    }
    var gal = 0
}

let instance = singleton.sharedInstance