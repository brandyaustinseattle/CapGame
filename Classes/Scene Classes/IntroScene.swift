//
//  IntroScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


class IntroScene: SKScene {

    var player = Player();
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene);
        
        let newScene = GameScene(fileNamed: "GameScene")!;
        newScene.scaleMode = .aspectFill;
        
        let doorway = SKTransition.doorway(withDuration: 3);
        self.view?.presentScene(newScene, transition: doorway);
        
        if touchedNode.name == "easybutton" {
            DifficultyManager.instance.setFactors(difficulty: "easy");
            
        } else if touchedNode.name == "mediumbutton" {
            DifficultyManager.instance.setFactors(difficulty: "medium");

        } else if touchedNode.name == "hardbutton" {
            DifficultyManager.instance.setFactors(difficulty: "hard");
        
        }
    }
    
    
    func initialize() {

        BackGroundManager.instance.createBG(scene: self, dynamic: false);
        BackGroundManager.instance.createBGAddOn(scene: self);
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
