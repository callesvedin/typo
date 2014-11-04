//
//  CrashProtocol.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-11-03.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import Foundation

protocol CJCrashDelegate {
    func didCrash(letter: Character)
}