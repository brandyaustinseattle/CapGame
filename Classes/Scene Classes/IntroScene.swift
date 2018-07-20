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
    let platform = PathItem(imageNamed: "startStep");
    
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
        
//        if touchedNode.name == "easybutton" {
//
//        } else if touchedNode.name == "easybutton" {
//
//        } else if touchedNode.name == "hardbutton" {
//            
//        } else {
//            return;
//        }
    }
    
    func initialize() {
        createStaticMountain();
        createTrees();
    
        addPlatform();
        createPlayer();

        addIntroBubble();
        addLevelsBubbles();
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
        player = Player(imageNamed: "standing1");
        player.initialize();
        player.position = CGPoint(x: 445, y: -175);

        self.addChild(player);
        player.stand();
    }
    
    func addIntroBubble() {
        
        let position = CGPoint(x: platform.position.x - 150, y: platform.position.y + 275);
        
        let label = LabelMaker(message: "let's go", messageSize: 100)
        
        let intro = Bubble(scene: self, type: "squarespeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(intro);
        intro.flashForever();
    }
    
    func addLevelsBubbles() {

        var y = self.size.height/2 - self.size.height/4;
        
        let difficultyTypes = ["easybutton", "mediumbutton", "hardbutton"];
        
        for type in difficultyTypes {
        
            let position = CGPoint(x: -175, y: y);
            
            let button = Bubble(scene: self, type: "\(type)", scale: 0.85, bubblePosition: position, label: nil)
        
            self.addChild(button);
            button.rotateBubble();
            
            y -= self.size.height/4;
        }
    
    }
    
}
