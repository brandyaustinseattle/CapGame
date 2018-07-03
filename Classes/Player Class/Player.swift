//
//  Player.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let player: UInt32 = 0x1 << 1;
    static let ground: UInt32 = 0x1 << 2;
}
    
class Player: SKSpriteNode {
    
    func initialize() {

        self.name = "Player";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.setPhysics()

        let jump = self.jumpPrep()
        self.run(SKAction.repeatForever(jump));

    }
    
    // start set physics body
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size());
        self.setScale(0.25);
        
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.player;
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.isDynamic = true;
        
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.ground;
    }
    // end set physics body
    
    
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
        
        let running = SKAction.animate(with: runningSequence, timePerFrame: TimeInterval(0.18), resize: true, restore: true);
        
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
