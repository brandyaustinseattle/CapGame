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
        
    var player = Player();
    var drink = Drink();
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveClouds();
    }
    
    func initialize() {
        physicsWorld.contactDelegate = self;

        createMountains();
        createClouds();
        
        createPlayer();
        addDrinkMatrix();
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
    
    func moveClouds() {
        
        enumerateChildNodes(withName: "cloud") {
            node, _ in
            
            let cloudsNode = node as! SKSpriteNode;
            
            cloudsNode.position.x -= 0.5;
            
            // less than because mountains are scrolling left
            if cloudsNode.position.x < -(self.frame.size.width) {
                cloudsNode.position.x += self.frame.size.width * 2;
            }
        };
    }
    
    func createPlayer() {
        player = Player(imageNamed: "testPlayer");
        player.initialize();
        player.position = CGPoint(x: 0, y: 0);
        
        // player needs to be smaller than default
        player.setScale(0.15);
        self.addChild(player);
        player.fly();
    }
    
    func addDrinkMatrix() {
        
        let x = CGFloat(-100);
        let y = CGFloat(100);
        
        drink = Drink(imageNamed: "drink");
        
        let referencePosition = CGPoint(x: x, y: y);
        let offsetYValue = CGFloat(0);
            
        drink.initialize(referencePosition: referencePosition, offsetYValue: offsetYValue);
        
        // drink needs to be smaller than default
        drink.setScale(0.10);
            
        self.addChild(drink);
    }
    
}
