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
    
    func createStaticBG(scene: SKScene) {
        let background = SKSpriteNode(imageNamed: "\(option)background");
        background.name = "background";
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        background.position = CGPoint(x: 0, y: 0);
        background.zPosition = 0;
        scene.addChild(background);
    
        if option == "C" {
            let snow = snowPulse(position: scene.position);
            scene.addChild(snow);
        }
    }
    
    func createBGAddOn(scene: SKScene) {
        let addOn = SKSpriteNode(imageNamed: "\(option)addon");
        addOn.name = "addOn";
        addOn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        addOn.position = CGPoint(x: 0, y:0);
        addOn.zPosition = 1;
        addOn.setScale(0.70);
        scene.addChild(addOn);
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
