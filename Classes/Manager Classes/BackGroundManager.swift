//
//  BackGroundManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/23/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class BackGroundManager {
    
    static let instance = BackGroundManager();
    
    private init() {}
    
    func createBG(scene: SKScene, dynamic: Bool? = true) {
        
        var num = Int();
        
        if dynamic == true {
            num = 1
        } else {
            num = 0
        }
        
        for i in 0...num {
            let background = SKSpriteNode(imageNamed: "\(option)background");
            background.name = "background";
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            background.position = CGPoint(x: CGFloat(i) * background.size.width, y:0);
            background.zPosition = 0;
            scene.addChild(background);
            
            if option == "C" {
                let snow = snowPulse(position: scene.position);
                scene.addChild(snow);
            }
        }
    }
    
    func createBGAddOn(scene: SKScene, dynamic: Bool? = true) {
        
        var num = Int();
        
        if dynamic == true {
            num = 1
        } else {
            num = 0
        }
        
        for i in 0...num {
            let addOn = SKSpriteNode(imageNamed: "\(option)addon");
            addOn.name = "addOn";
            addOn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            addOn.position = CGPoint(x: CGFloat(i) * addOn.size.width, y:0);
            addOn.zPosition = 1;
            scene.addChild(addOn);
        }
    }
    
    func moveBGAndAddOn(scene: SKScene) {
        
        let names = ["background", "addOn"];
        
        for name in names {
        
            scene.enumerateChildNodes(withName: name) {
                node, _ in
            
                let backgroundsNode = node as! SKSpriteNode;
            
                backgroundsNode.position.x -= 8;
            
                if backgroundsNode.position.x < -(backgroundsNode.size.width) {
                    backgroundsNode.position.x += backgroundsNode.size.width * 2;
                }
            }
        }
    }
    
    func addPlatform(scene: SKScene) {
        
        let platform = PathItem(imageNamed: "\(option)startStep");

        platform.initialize();
        
        let x = (scene.size.width/2) - (platform.size.width/2);
        let y = -(scene.frame.size.height/2) + (platform.size.height/2);
        platform.position = CGPoint(x: x, y: y);
    
        scene.addChild(platform);
    }

}
