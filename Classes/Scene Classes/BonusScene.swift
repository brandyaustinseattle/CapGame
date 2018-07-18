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
    
    var pointsLabel = SKLabelNode();
    var pointsBG = SKSpriteNode();
    
    var touchLocation = CGPoint();
    
    var player = Player();
    var drink = Object();
    var lemon = Object();
    
    override func didMove(to view: SKView) {
        initialize();
        
        pointsBG = Points.instance.getBackground();
        pointsLabel = Points.instance.getLabel();
        
        Points.instance.updatePointsDisplay(background: pointsBG, pointsLabel: pointsLabel)
        self.addChild(pointsBG);
        self.addChild(pointsLabel);
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveClouds();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let destination = touch.location(in: self)
        let move = SKAction.move(to: destination, duration: 2)
        player.removeAction(forKey: "move")
        player.run(move, withKey: "move")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAction(forKey: "move");
    }
    
    // same as drink portion of didBegin in GameScene
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }

        if firstBody.node?.name == "Player" && secondBody.node?.name == "Drink" || secondBody.node?.name == "Lemon" {
            
            let objectName = secondBody.node?.name;
            Points.instance.increment(objectName: objectName!);
//            Points.instance.updateLabel(pointsLabel: pointsLabel);
            
            let position = secondBody.node?.position;
            let cPulse = contactPulse(position: position!);
            self.addChild(cPulse);
            
            secondBody.node?.removeFromParent()
        }
    }

    
    func initialize() {
        physicsWorld.contactDelegate = self;

        createMountains();
        createClouds();
        
        createPlayer();
        addObjectsMatrix();
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
            let cloudSizeRandom = Int.random(min: 0, max: 2);
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
    
    func addObjectsMatrix() {
        
        var x = CGFloat(-(self.frame.size.width/2) + self.frame.size.width/6);
        var y = CGFloat(self.frame.size.height/2 - self.frame.size.height/4);
        
        let lemonFactor = 3;
        
        // 3 rows and 5 columns of drinks/lemons
        for i in 1...3 {
            for j in 1...5 {
                
                if (i == 3 && j == 1) {
                    // do nothing bc player will be in this area
                } else {
        
                    drink = Object(imageNamed: "drink");
                    lemon = Object(imageNamed: "lemon");
        
                    let referencePosition = CGPoint(x: x, y: y);
            
                    drink.initialize(referencePosition: referencePosition, offsetYValue: CGFloat(0), type: "Drink");
                    lemon.initialize(referencePosition: referencePosition, offsetYValue: CGFloat(0), type: "Lemon");
                    
                    let lemonRandom = Int.random(min: 1, max: 10);
                    
                    if lemonRandom <= lemonFactor {
                        self.addChild(lemon);
                    } else {
                        self.addChild(drink);
                    };
                }
                
                x += self.frame.size.width/6;
            }
            
            y -= (self.frame.size.height/2 - self.frame.size.height/4);
            x = (-(self.frame.size.width/2) + self.frame.size.width/6);
        };
    }
    
}
