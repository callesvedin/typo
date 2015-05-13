//
//  GameObject.swift
//  Typo
//
//  Created by Carl-Johan Svedin on 2014-07-01.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import SpriteKit
class GameObject:SKNode{
    let asteroidCategory: UInt32 = 1 << 0
    let groundCategory: UInt32 = 1 << 1
    let laserCategory: UInt32 = 1 << 2
    
}
