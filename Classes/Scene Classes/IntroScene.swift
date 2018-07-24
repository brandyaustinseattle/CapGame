//
//  IntroScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


class IntroScene: SKScene, SKPhysicsContactDelegate {

    var player = Player();
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
 
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "pathItem" {
            playerOnPath = true;
            playerRepeatJumps = 0;
            player.stand();
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if playerRepeatJumps >= 2 {
            return;
        } else {
            playerOnPath = false;
            playerRepeatJumps += 1;
            player.jumpUp();
        }
        player.jumpUp();
        
        let touch:UITouch = touches.first!;
        let positionInScene = touch.location(in: self);
        let touchedNode = self.atPoint(positionInScene);
        
        if touchedNode.name == "easybutton" {
            DifficultyManager.instance.setFactors(difficulty: "easy");
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);
            
        } else if touchedNode.name == "mediumbutton" {
            DifficultyManager.instance.setFactors(difficulty: "medium");
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);

            
        } else if touchedNode.name == "hardbutton" {
            DifficultyManager.instance.setFactors(difficulty: "hard");
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);

        }
    }
    
    
    func initialize() {
        physicsWorld.contactDelegate = self;

        BackGroundManager.instance.createBG(scene: self, dynamic: false);
        BackGroundManager.instance.createBGAddOn(scene: self, dynamic: false);
        BackGroundManager.instance.addPlatform(scene: self);

        createPlayer();

//        addIntroBubble();
        addLevelsBubbles();
    }

    func createPlayer() {
        player = Player(imageNamed: "standing1");
        player.initialize();
        player.position = CGPoint(x: 445, y: 100);

        self.addChild(player);
        player.stand();
    }
    
//    func addIntroBubble() {
//
//        let position = CGPoint(x: platform.position.x - 150, y: platform.position.y + 275);
//
//        let label = LabelMaker(message: "let's go", messageSize: 100)
//
//        let intro = Bubble(type: "squarespeech", scale: 0.45, bubblePosition: position, label: label)
//
//        delay(time: 1.25) {
//            self.addChild(intro);
//            ActionManager.instance.flashForever(node: intro);
//        }
//    }
    
    func addLevelsBubbles() {

        let difficultyTypes = ["easybutton", "mediumbutton", "hardbutton"];
        
        var y = self.size.height/2 - self.size.height/4 - frame.size.height;

        var time = Double(0.5);
        
        for type in difficultyTypes {

            delay(time: time) {
            
                let position = CGPoint(x: -175, y: y);

                let button = Bubble(type: "\(type)", scale: 0.85, bubblePosition: position, label: nil)

                let move = SKAction.moveBy(x: 0, y: self.frame.size.height, duration: 0.75)

                self.addChild(button);
                ActionManager.instance.rotateBackForth(node: button, denominator: 100);
                button.run(move);

                y -= self.size.height/4;
            }
            time += 0.5;

        }

    }
    
}
