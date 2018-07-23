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

    var pointsLabel = SKLabelNode();
    var pointsBG = SKSpriteNode();
    var timer = Timer();
    
    var player = Player();
    let platform = PathItem(imageNamed: "\(option)startStep");
    
    override func didMove(to view: SKView) {
        initialize();
        
        let pointsBubble = Points.instance.getPointsBubble();
        self.addChild(pointsBubble);
    }
    
    func initialize() {
        createStaticBG();
        createTrees();
        
        addPlatform();
        createPlayer();
        
        addGameOverBubble();
        
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(countDown), userInfo: nil, repeats: true);
    }
    
    @objc func countDown() {
        if Points.instance.value == 0 {
            timer.invalidate();
        }
        
        Points.instance.decrement();
        
        if let child = self.childNode(withName: "roundcloud") as? SKSpriteNode {
            child.removeFromParent()
        }
        
        let pointsBubble = Points.instance.getPointsBubble();
        self.addChild(pointsBubble);
    }
    
    func createStaticBG() {
        let background = SKSpriteNode(imageNamed: "\(option)background");
        background.name = "background";
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        background.position = CGPoint(x: 0, y: 0);
        background.zPosition = 0;
        self.addChild(background);
    }
    
    func createTrees() {
        let trees = SKSpriteNode(imageNamed: "\(option)addon");
        trees.name = "\(option)AddOn";
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
        player.position = CGPoint(x: 445, y: 100);
        
        self.addChild(player);
        player.gameOver();
    }
    
    func addGameOverBubble() {
        
        let position = CGPoint(x: platform.position.x - 215, y: platform.position.y + 300);
        
        let label = LabelMaker(message: "game over", messageSize: 70)
        
        let gameOver = Bubble(type: "roundspeech", scale: 0.45, bubblePosition: position, label: label)
        
        delay(time: 5) {
            self.addChild(gameOver);
            gameOver.flashForever();
        }
    }

}
