//
//  RandomNumberGenerator.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-06-07.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import Foundation
class RandomNumberGenerator {
    
    func randomInt(from:Int, to:Int) -> Int {
        return from+random(to-from+1)
    }
    
    func random(count:Int) -> Int {
        return Int(arc4random_uniform(UInt32(count)))
    }
}