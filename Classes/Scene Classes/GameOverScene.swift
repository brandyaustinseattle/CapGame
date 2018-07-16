//
//  GameOverScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/16/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameOverScene: SKScene, SKPhysicsContactDelegate {

    var player = Player();
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func initialize() {
        addStand();
        createPlayer();
        
        createMountains();
        createTrees();
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
    
    func createTrees() {
        let trees = SKSpriteNode(imageNamed: "trees");
        trees.name = "trees";
        trees.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        trees.position = CGPoint(x: 0, y:0);
        trees.zPosition = 1;
        trees.setScale(0.70);
        self.addChild(trees);
    }
    
    func createPlayer() {
        player = Player(imageNamed: "gameover1");
        player.initialize();
        player.position = CGPoint(x: 435, y: 200);
        
        self.addChild(player);
        player.gameOver();
    }
    
    func addStand() {
        let stand = PathItem(imageNamed: "startStep");
        stand.initialize();
        
        let x = (self.size.width/2) - (stand.size.width/2);
        let y = -(self.frame.size.height/2) + (stand.size.height/2);
        stand.position = CGPoint(x: x, y: y);
        
        self.addChild(stand);
    }
    
}
