//
//  BonusScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


class BonusScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func initialize() {
        physicsWorld.contactDelegate = self;

        createMountains();
        createClouds();
        
        addDrinks();
    }
    
    func createMountains() {
        let mountains = SKSpriteNode(imageNamed: "mountains");
        mountains.name = "mountains";
        mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        mountains.zPosition = 0;
        self.addChild(mountains);
    }
    
    func createClouds() {
        for i in 1...3 {
            let cloud = SKSpriteNode(imageNamed: "cloud");
            cloud.name = "cloud";
            cloud.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            cloud.position = CGPoint(x: cloud.size.width * CGFloat(i) / 3 - 100, y: cloud.size.height * CGFloat(i) / 2 - 150);
            cloud.zPosition = 1;
            cloud.setScale(0.5);
            self.addChild(cloud);
        }
    }
    
    func addDrinks() {
        func createPlayer() {
            player = Player(imageNamed: "testPlayer");
            player.initialize();
            player.position = CGPoint(x: -500, y: 200);
            
            self.addChild(player);
        }
    }
    
}
