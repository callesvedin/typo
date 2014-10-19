//
//  CharacterImageFactory.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-10-19.
//  Copyright (c) 2014 Carl-Johan Svedin. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterImageFactory{
    class var shared:CharacterImageFactory {
        struct Static {
            static let instance :CharacterImageFactory=CharacterImageFactory()
        }
        return Static.instance
    }
    
    var characterImageMapping:Dictionary<Character,NSImage> = Dictionary<Character,NSImage>()
    
    
    func getImageForLetter(character:Character)-> NSImage? {
        if var image = characterImageMapping[character] {
            return image
        }else{
            if var image = createImage(character) {
                characterImageMapping[character] = image
                return image
            }
        }
        return nil;
    }
    
    func createImage(character:Character)-> NSImage? {
        
        if let f = NSFont(name: "Helvetica", size:28) {
            let attributes = [NSFontAttributeName:f, NSForegroundColorAttributeName:NSColor.whiteColor()]
            let ST = String(character)
            let myString: NSString = ST as NSString
            let size: CGSize = myString.sizeWithAttributes(attributes)
            let image = NSImage(size: size)
            image.lockFocus()
            myString.drawAtPoint(NSZeroPoint, withAttributes: attributes)
            image.unlockFocus()
            return image;
        }
        return nil;
    }
}

