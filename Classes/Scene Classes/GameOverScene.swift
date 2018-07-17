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
    let platform = PathItem(imageNamed: "startStep");
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func initialize() {
        addPlatform();
        createPlayer();
        
        createStaticMountain();
        createTrees();
        
        createThought();
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
    
    func createPlayer() {
        player = Player(imageNamed: "gameover1");
        player.initialize();
        player.position = CGPoint(x: 445, y: 200);
        
        self.addChild(player);
        player.gameOver();
    }
    
    func addPlatform() {
        platform.initialize();
        
        let x = (self.size.width/2) - (platform.size.width/2);
        let y = -(self.frame.size.height/2) + (platform.size.height/2);
        platform.position = CGPoint(x: x, y: y);
        
        self.addChild(platform);
    }
    
    func createThought() {
        let thought
            = SKSpriteNode(imageNamed: "thought");
        thought.name = "scroll";
        thought.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        thought.zPosition = 2;
        
        thought.setScale(0.5);

        let x = platform.position.x - 200;
        let y = platform.position.y + 300;
        
        thought.position = CGPoint(x: x, y: y);
        
        self.addLabel(thought: thought);
        self.addChild(thought);
        
        self.flashThought(thought: thought);
    }
    
    func addLabel(thought: SKSpriteNode) {

        let x = thought.position.x;
        let y = thought.position.y;
        
        let gameOverLabel = SKLabelNode(fontNamed: "Marker Felt");
        gameOverLabel.text = "game over";
        gameOverLabel.fontColor = UIColor.black;
        gameOverLabel.fontSize = 85;
        gameOverLabel.zPosition = 4;
        
        gameOverLabel.position = CGPoint(x: x - 325, y: y + 50);
        thought.addChild(gameOverLabel);
    }
    
    func flashThought(thought: SKSpriteNode) {
        
        let fadeIn = SKAction.fadeIn(withDuration: 1);
        let wait = SKAction.wait(forDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1);
        let sequence = SKAction.sequence([fadeIn, wait, fadeOut]);
        
        thought.run(SKAction.repeatForever(sequence), withKey: "flash");
    }
    
}
