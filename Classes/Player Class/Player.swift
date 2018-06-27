//
//  Player.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

// z.Position needs to be greater than that of ground

import SpriteKit

class Player: SKSpriteNode {
    
    func initialize() {
        self.name = "Player";
        self.zPosition = 2;
        self.anchorPoint = CGPoint(x: 0, y: 0);
        self.setScale(0.25);
    }
    
}
