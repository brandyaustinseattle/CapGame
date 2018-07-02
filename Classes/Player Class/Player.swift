//
//  Player.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    // set data type of constants to UInt32 then assign values to the constants; could probably use enum instead of struct
    static let player: UInt32 = 0x1 << 1;
    static let ground: UInt32 = 0x1 << 2;
}
    
class Player: SKSpriteNode {
    
    func initialize() {
        
        // start code: standing
        var standSequence = [SKTexture]();
        
        for i in 1...6 {
            let imageName = "standing\(i)";
            standSequence.append(SKTexture(imageNamed: imageName));
        }
        
        let standing = SKAction.animate(with: standSequence, timePerFrame: TimeInterval(0.18), resize: true, restore: true);
        // end code: standing

        
        self.name = "Player";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size());
        self.setScale(0.25);
        
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = PhysicsCategory.player;
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;
        
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.ground;
        
        self.run(SKAction.repeatForever(standing));
    }
    
}
