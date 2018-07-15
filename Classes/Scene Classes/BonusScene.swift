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
    
    let pointsLabel = SKLabelNode(fontNamed: "Marker Felt");
        
    var player = Player();
    var drink = Drink();
    
    override func didMove(to view: SKView) {
        initialize();
        
        Points.instance.updateLabel(pointsLabel: pointsLabel);
        self.addChild(pointsLabel);
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
        
        let cloudSizeArray = [CGFloat(0.55), CGFloat(0.8), CGFloat(1.05)];
        
        var x = CGFloat(self.frame.size.width/2);
        var y = CGFloat(self.frame.size.height/2 - (self.frame.size.height/4));
        
        for _ in 1...2 {
            let cloud = SKSpriteNode(imageNamed: "cloud");
            cloud.name = "cloud";
            cloud.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            
            // used to randomly determine x position of clouds
            let offsetXValue = Int.random(min: 100, max: 500);
            x -= CGFloat(offsetXValue);

            cloud.position = CGPoint(x: x, y: y);
            cloud.zPosition = 1;
            
            // used to randomly determine size of clouds
            let cloudSizeRandom = Int.random(min: 0, max: 3);
            let cloudSize = cloudSizeArray[cloudSizeRandom];
            cloud.setScale(cloudSize);
            
            self.addChild(cloud);
            
            // used to randomly determine y position of clouds
            let offsetYValue = Int.random(min: 10, max: 80);
            y -= self.frame.size.height/4 + CGFloat(offsetYValue);
        }
    }
    
    // same as move mountains function in GameScene
    func moveClouds() {
        
        enumerateChildNodes(withName: "cloud") {
            node, _ in
            
            let cloudsNode = node as! SKSpriteNode;
            
            cloudsNode.position.x -= 0.5;
            
            // less than because clouds are scrolling left
            if cloudsNode.position.x < -(self.frame.size.width) {
                cloudsNode.position.x += self.frame.size.width * 2;
            }
        };
    }
    
    func createPlayer() {
        player = Player(imageNamed: "flying1");
        player.initialize();
        
        let x = CGFloat(-(self.frame.size.width/2) + self.frame.size.width/6);
        let y = CGFloat(self.frame.size.height/2 - 3 * (self.frame.size.height/4));
        
        player.position = CGPoint(x: x, y: y);
        
        self.addChild(player);
        player.fly();
    }
    
    func addDrinkMatrix() {
        
        var x = CGFloat(-(self.frame.size.width/2) + self.frame.size.width/6);
        var y = CGFloat(self.frame.size.height/2 - self.frame.size.height/4);
        
        // 3 rows and 5 columns of drinks
        for i in 1...3 {
            for j in 1...5 {
                
                if (i == 3 && j == 1) {
                    // do nothing bc player will be in this area
                } else {
        
                    drink = Drink(imageNamed: "drink");
        
                    let referencePosition = CGPoint(x: x, y: y);
                    let offsetYValue = CGFloat(0);
            
                    drink.initialize(referencePosition: referencePosition, offsetYValue: offsetYValue);
                    self.addChild(drink);
                }
                
                x += self.frame.size.width/6;
            }
            
            y -= (self.frame.size.height/2 - self.frame.size.height/4);
            x = (-(self.frame.size.width/2) + self.frame.size.width/6);
        };
    }
    
}
