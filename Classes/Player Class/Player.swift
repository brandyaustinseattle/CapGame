//
//  Player.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class Player: SKSpriteNode {
    
    let playerHead = SKSpriteNode();
    let playerBody = SKSpriteNode();
    
    func initialize() {
                
        self.name = "Player";
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysicsHead();
        self.setPhysicsBody();
    }
    
    
    

//    self.physicsBody?.restitution = 0;
//    self.physicsBody?.collisionBitMask = ColliderType.CLOUD;
//    self.physicsBody?.contactTestBitMask = ColliderType.DARK_CLOUD_AND_COLLECTABLES;
    
    
    
    
    // start set physics
    func setPhysicsHead() {

        // naming head so both head and body can be referenced with Player
        playerHead.name = "Player";
        playerHead.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2.55, center: CGPoint(x:90, y:150));
        playerHead.physicsBody?.usesPreciseCollisionDetection = true;
        playerHead.physicsBody?.categoryBitMask = PhysicsCategory.PlayerHead;
        playerHead.physicsBody?.affectedByGravity = true;
        playerHead.physicsBody?.allowsRotation = false;
        playerHead.physicsBody?.isDynamic = true;
        
        // pinned prevents head from rolling off
        playerHead.physicsBody?.pinned = true;
        
        playerHead.physicsBody?.contactTestBitMask = PhysicsCategory.Drink;
        
        self.addChild(playerHead);
    }
    
    func setPhysicsBody() {
        
        playerBody.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - CGFloat(490), height: self.size.height));
        playerBody.physicsBody?.usesPreciseCollisionDetection = true;
        playerBody.physicsBody?.categoryBitMask = PhysicsCategory.PlayerBody;
        playerBody.physicsBody?.affectedByGravity = true;
        playerBody.physicsBody?.allowsRotation = false;
        playerBody.physicsBody?.isDynamic = true;
        
        playerBody.physicsBody?.collisionBitMask = PhysicsCategory.Ground;
        playerBody.physicsBody?.contactTestBitMask = PhysicsCategory.Ground | PhysicsCategory.Stand;
        
        self.physicsBody = playerBody.physicsBody;
        self.setScale(0.25);
    }
    // end set physics
    
    
    func jump() {
        let jumping = jumpPrep();

        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0);
        self.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 8500));
        
        self.run(jumping);
    }
    
    func fly() {
        let flying = flyingPrep();
        
        playerBody.physicsBody?.affectedByGravity = false;
        playerHead.physicsBody?.affectedByGravity = false;

        self.run(flying);
        self.run(SKAction.repeatForever(flying), withKey: "flyKey");
    }
    
    func runFast() {
        let running = runningPrep();

        self.run(running);
        self.run(SKAction.repeatForever(running), withKey: "runKey");
    }
    
    // start animations prep
    func standingPrep() -> SKAction {
        var standSequence = [SKTexture]();
    
        for i in 1...6 {
            let imageName = "standing\(i)";
            standSequence.append(SKTexture(imageNamed: imageName));
        }
    
        let standing = SKAction.animate(with: standSequence, timePerFrame: TimeInterval(0.18), resize: true, restore: true);
        
        return standing;
    }
    
    func runningPrep() -> SKAction {
        var runningSequence = [SKTexture]();
        
        for i in 1...4 {
            let imageName = "running\(i)";
            runningSequence.append(SKTexture(imageNamed: imageName));
        }
        
        let running = SKAction.animate(with: runningSequence, timePerFrame: TimeInterval(0.28), resize: true, restore: true);
        
        return running;
    }
    
    func jumpPrep() -> SKAction {
        var jumpSequence = [SKTexture]();
        
        for i in 1...2 {
            let imageName = "jumpup\(i)";
            jumpSequence.append(SKTexture(imageNamed: imageName));
        }
        
        for i in 1...2 {
            let imageName = "jumpfall\(i)";
            jumpSequence.append(SKTexture(imageNamed: imageName));
        }
        
        let jump = SKAction.animate(with: jumpSequence, timePerFrame: TimeInterval(0.18), resize: true, restore: true);
        
        return jump;
    }
    
    func flyingPrep() -> SKAction {
        var flyingSequence = [SKTexture]();
        
        for i in 1...6 {
            let imageName = "flying\(i)";
            flyingSequence.append(SKTexture(imageNamed: imageName));
        }
        
        let flying = SKAction.animate(with: flyingSequence, timePerFrame: TimeInterval(0.28), resize: true, restore: true);
        
        return flying;
    }
    // end animations prep
    
}
