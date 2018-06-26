//
//  GameplayScene.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var player = Player();
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func initialize() {
        createPlayer();
    }
    
    func createPlayer() {
        player = Player(imageNamed: "testPlayer");
        player.initialize();
        player.position = CGPoint(x: -650, y: -200);
        self.addChild(player);
    }
    
    
}
