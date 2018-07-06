//
//  Player.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let Player: UInt32 = 0x1 << 1;
    static let Ground: UInt32 = 0x1 << 2;
}
    
class Player: SKSpriteNode {
    
    func initialize() {

        self.name = "Player";
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics();
        
        let running = self.runningPrep();
        self.run(SKAction.repeatForever(running), withKey: "runKey");
    }
    
    // start set physics body
    func setPhysics() {
//        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size());

        let playerHead = SKPhysicsBody(circleOfRadius: self.size.width/2.55, center: CGPoint(x:90, y:150));
        let playerBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - CGFloat(490),
                                                           height: self.size.height));

        self.physicsBody = SKPhysicsBody(bodies: [playerHead, playerBody]);
        
        self.setScale(0.25);
        
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player;
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;
        
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ground;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ground;
    }
    // end set physics body
    
    
    func jump() {

        let jumping = jumpPrep();
        self.run(jumping);

        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0);
        self.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 8500));
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
    // end animations prep
    
}
