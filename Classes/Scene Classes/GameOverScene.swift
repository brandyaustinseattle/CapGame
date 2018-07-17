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

    let pointsLabel = SKLabelNode(fontNamed: "Marker Felt");
    
    var player = Player();
    let platform = PathItem(imageNamed: "startStep");
    
    var thought = Speech();
    
    override func didMove(to view: SKView) {
        initialize();
        
        let pointsBG = Points.instance.getBackground();
        self.addChild(pointsBG);
        
        Points.instance.updateLabel(pointsLabel: pointsLabel)
        self.addChild(pointsLabel);
    }
    
    func initialize() {
        createStaticMountain();
        createTrees();
        
        addPlatform();
        createPlayer();
        
        delayGameOver();
    }
    
    
    func createStaticMountain() {
        let mountains = SKSpriteNode(imageNamed: "mountains");
        mountains.name = "mountains";
        mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        mountains.position = CGPoint(x: 0, y: 0);
        mountains.zPosition = 0;
        self.addChild(mountains);
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
    
    func addPlatform() {
        platform.initialize();
        
        let x = (self.size.width/2) - (platform.size.width/2);
        let y = -(self.frame.size.height/2) + (platform.size.height/2);
        platform.position = CGPoint(x: x, y: y);
        
        self.addChild(platform);
    }
    
    func createPlayer() {
        player = Player(imageNamed: "gameover1");
        player.initialize();
        player.position = CGPoint(x: 445, y: 200);
        
        self.addChild(player);
        player.gameOver();
    }
    
    func delayGameOver() {
        let wait = SKAction.wait(forDuration: 1);
        let addGO = SKAction.run(addGameOver);
        let sequence = SKAction.sequence([wait, addGO]);
        
        self.run(sequence);
    }
    
    func addGameOver() {
        thought = Speech(imageNamed: "thought");
        thought.initialize(type: "Thought")
        
        let position = platform.position;
        
        thought.addThought(scene: self, text: "game over", position: position)
        thought.flashThought();
    }
}
