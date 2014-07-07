// Playground - noun: a place where people can play

import Cocoa

let path = NSBundle.mainBundle().pathForResource("Levels",ofType:"plist")

let levelArray = NSArray(contentsOfFile:path)

let dict : NSDictionary = levelArray[0] as NSDictionary
let characters = dict.objectForKey("Characters") as NSArray

characters
