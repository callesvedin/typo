//
//  AppDelegate.swift
//  Typo
//
//  Created by carl-johan.svedin on 2014-10-13.
//  Copyright (c) 2014 carl-johan.svedin. All rights reserved.
//


import Cocoa
import SpriteKit

//extension SKNode {
//    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
//        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
//            
////            var sceneData = Data(bytesNoCopy: path, count: .DataReadingMappedIfSafe, deallocator: nil)!
//            var sceneData = Data(contentsOf: URL(path))!
////            var sceneData = Data(bytesNoCopy: path, count: Int, deallocator: Data.Deallocator)
//            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
//            
//            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
//            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKScene
//            archiver.finishDecoding()
//            return scene
//        } else {
//            return nil
//        }
//    }
//}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /* Pick a size for the scene */
        if let scene = SKScene(fileNamed: "StartScene") {
//        if let scene = StartScene.unarchiveFromFile("StartScene") as? StartScene {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
           // self.skView!.frameInterval = 2
            self.skView!.presentScene(scene)
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = true
            
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true
            self.skView!.showsPhysics = false
//            self.skView!.showsFields = true
            
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

