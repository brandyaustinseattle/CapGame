//
//  Player.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    // set data type of constants to UInt32 then assign values to the constants
    static let player: UInt32 = 0x1 << 1;
    static let ground: UInt32 = 0x1 << 2;
}
    
class Player: SKSpriteNode {
    
    func initialize() {
        self.name = "Player";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0, y: 0);
        self.setScale(0.25);
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.categoryBitMask = PhysicsCategory.player;
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;

        self.physicsBody?.collisionBitMask = PhysicsCategory.ground;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.ground;
    }
    
}
