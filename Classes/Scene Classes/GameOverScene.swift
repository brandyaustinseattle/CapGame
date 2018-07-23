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
    let pointsBubble = Points.instance.getPointsBubble();

    
    override func didMove(to view: SKView) {
        initialize();
        
        self.addChild(pointsBubble);
    }
    
    func initialize() {

        BackGroundManager.instance.createBG(scene: self, dynamic: false);
        BackGroundManager.instance.createBGAddOn(scene: self);
        BackGroundManager.instance.addPlatform(scene: self);
        
//        createPlayer();
//
        addGameOverBubble();
        
        delay(time: 3) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.countDownPoints), userInfo: nil, repeats: true);
        }
    }
    
    @objc func countDownPoints() {
        
        if Points.instance.value == 0 {
            timer.invalidate();
            return
        }
        
        Points.instance.decrement();
        
        let label = LabelMaker(message: "\(Points.instance.value)", messageSize: 60)
        pointsBubble.updateLabel(newLabel: label)
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
        
        delay(time: 3) {
            self.addChild(gameOver);
            ActionManager.instance.flashForever(node: gameOver);
        }
    }

}
