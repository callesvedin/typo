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
    
    var characterImageMapping:Dictionary<Character,SKTexture> = Dictionary<Character,SKTexture>()
    
    
    func getImageForLetter(_ character:Character)-> SKTexture? {
        if let image = characterImageMapping[character] {
            return image
        }else{
            if let image = createImage(character) {
                characterImageMapping[character] = image
                return image
            }
        }
        return nil;
    }
    
    func createImage(_ character:Character)-> SKTexture? {
        
        if let f = NSFont(name: "Helvetica", size:36) {
            let attributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.font):f, convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor):NSColor.white]
            let ST = String(character)
            let myString: NSString = ST as NSString
            let size: CGSize = myString.size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))
            let image = NSImage(size: size)
            image.lockFocus()
            myString.draw(at: NSZeroPoint, withAttributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))
            image.unlockFocus()
            let texture = SKTexture(image: image)
            return texture;
        }
        return nil;
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
