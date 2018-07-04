//
//  GameplayScene.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var player = Player();
    var jumpCount = 0;
    var groundTouch = false;
    
    let worldNode:SKNode = SKNode();
    let tapRec = UITapGestureRecognizer();
    
    override func update(_ currentTime: TimeInterval) {
        moveMountains();
        movePath();
    }
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if permitJump {
//            permitJump = false;
//            player.jump();
//        }
        
        print("before");
        print(groundTouch);
        
        player.jump();
        
        print("after");
        print(groundTouch);

//        print("before");
//        print(jumpCount);
//        print(groundTouch);
//        print("BREAK");
//
//        if jumpCount < 2  {
//            player.jump();
//            jumpCount += 1;
//        }
//
//        print("after");
//        print(jumpCount);
//        print(groundTouch);
//        print("BREAK");
//
//        if jumpCount == 2 {
//            jumpCount = 0;
//            print("inside")
//            print(jumpCount);
//            print(groundTouch);
//            print(groundTouch);
//            print("BREAK");
//        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();

        // maker sure first body is player if player is present
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }

        if firstBody.node?.name == "Player" && secondBody.node?.name == "lowAddOn" {
            groundTouch = true;
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        // maker sure first body is player if player is present
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "lowAddOn" {
            groundTouch = false;
        }
    }

    
//    func collisionBetween(objectOne: SKNode, objectTwo: SKNode) {
//        if objectOne.name == "Player" {
//            destroy(ball: ball)
//        } else if objectTwo.name == "Player" {
//            destroy(ball: ball)
//        }
//    }
    
    func initialize() {
        physicsWorld.contactDelegate = self;
        
        createPlayer();
        createMountains();
        createTrees();
        createPath();
    }

    func createMountains() {
        for i in 0...1 {
            let mountains = SKSpriteNode(imageNamed: "mountains");
            mountains.name = "mountains";
            mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            mountains.position = CGPoint(x: CGFloat(i) * mountains.size.width, y:0);
            mountains.zPosition = 0;
            self.addChild(mountains);
        }
    }
    
    func moveMountains() {
        
        enumerateChildNodes(withName: "mountains") {
            node, _ in
            
            let mountainsNode = node as! SKSpriteNode;
            
            mountainsNode.position.x -= 8;
            
            // less than because mountains are scrolling left
            if mountainsNode.position.x < -(mountainsNode.size.width) {
                mountainsNode.position.x += mountainsNode.size.width * 2;
            }
        };
    }
    
    func movePath() {
        
        enumerateChildNodes(withName: "lowAddOn") {
            node, _ in
            
            let lowAddOnNode = node as! SKSpriteNode;
            
            lowAddOnNode.position.x -= 15;
            
        };
    }
    
    func createTrees() {
        let trees = SKSpriteNode(imageNamed: "trees");
        trees.name = "trees";
        trees.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        trees.position = CGPoint(x: 0, y:0);
        trees.zPosition = 1;
        trees.setScale(0.70);
        self.addChild(trees);
    }
    
    
    func createPath() {
        for i in 0...1800 {
            let lowAddOn = SKSpriteNode(imageNamed: "low-add-on");
            lowAddOn.name = "lowAddOn";
            lowAddOn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            lowAddOn.position = CGPoint(x: CGFloat(i) * (lowAddOn.size.width * 0.55) + -595, y: -305);
            lowAddOn.zPosition = 3;
            lowAddOn.setScale(0.55);
            
            lowAddOn.physicsBody = SKPhysicsBody(rectangleOf: lowAddOn.size);
            lowAddOn.physicsBody?.affectedByGravity = false;
            lowAddOn.physicsBody?.isDynamic = false;
            lowAddOn.physicsBody?.categoryBitMask = PhysicsCategory.Ground;
            
            self.addChild(lowAddOn);
        }
    }
    
    func createPlayer() {
        player = Player(imageNamed: "testPlayer");
        player.initialize();
        player.position = CGPoint(x: -550, y: 200);
        
        self.addChild(player);
    }

}
