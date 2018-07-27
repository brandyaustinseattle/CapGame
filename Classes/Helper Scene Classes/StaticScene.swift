//
//  StaticSceneManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/23/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameKit


class StaticScene: SKScene, SKPhysicsContactDelegate {
    
    var text: String = "";
    var speechBubble = SKSpriteNode();
    
    var player = Player();
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    override func didMove(to view: SKView) {
        self.setUp();
    }
    
    func setUp() {
        
        NSException(name:NSExceptionName(rawValue: "name"), reason:"Override this method in your subclass please", userInfo:nil).raise()
    }
    
    func initialize(playerImage: String) {
        physicsWorld.contactDelegate = self;
        BackGroundManager.instance.createBG(scene: self, dynamic: false);
        BackGroundManager.instance.createBGAddOn(scene: self, dynamic: false);
        
        addNameLogo();
        
        addPlatform(scene: self);
        createPlayer(playerImage: playerImage);
    }
    
    func addNameLogo() {
        let logo = SKSpriteNode(imageNamed: "logoWhite");
        logo.setScale(0.5);
        
        logo.position = CGPoint(x: -(frame.size.width/2) + logo.size.width/2 + 30, y: frame.size.height/2 - logo.size.height/2 - 30)
        logo.zPosition = 8;
        
        self.addChild(logo);
    }
    
    
    func managePlayerJumpsOnTouch() {
        speechBubble.isHidden = true;
        
        if playerRepeatJumps >= 2 {
            return;
        } else {
            playerOnPath = false;
            playerRepeatJumps += 1;
            player.jumpUp();
        }
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
            
            if speechBubble.texture == nil {
                if text != "" {
                    addSpeechBubble(message: text);
                }
            } else {
                speechBubble.isHidden = false;
            }
        }
        
        if firstBody.node?.name == "Player" && (secondBody.node?.name == "Drink" || secondBody.node?.name == "Cake") {
            let position = secondBody.node?.position;
            let cPulse = ActionManager.instance.contactPulse(position: position!);
            self.addChild(cPulse);
            
            secondBody.node?.removeFromParent();
        }
    }
    
    func addPlatform(scene: SKScene) {
        
        let platform = PathItem(imageNamed: "\(option)startStep");
        
        platform.initialize();
        
        let x = (scene.size.width/2) - (platform.size.width/2);
        let y = -(scene.frame.size.height/2) + (platform.size.height/2);
        platform.position = CGPoint(x: x, y: y);
        
        scene.addChild(platform);
    }
    
    func createPlayer(playerImage: String) {
        player = Player(imageNamed: playerImage);
        player.initialize();
        player.position = CGPoint(x: 445, y: -100);
        
        self.addChild(player);
        player.stand();
        
        addDrink();
    }
    
    func addDrink() {
        delay(time: 2) {
            let drink = Consumable(imageNamed: "\(option)drink");
            let referencePosition = CGPoint(x: self.player.position.x, y: self.player.position.y);

            let offsetYValue = CGFloat(250);
            
            drink.initialize(referencePosition: referencePosition, offsetYValue: offsetYValue, type: "Drink");
            
            self.addChild(drink);
        }
    }

    func addSpeechBubble(message: String) {
        
        let position = CGPoint(x: player.position.x + 100, y: player.position.y + 150);
        let label = LabelMaker(message: message, messageSize: 100)
        speechBubble = Bubble(type: "squarespeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(speechBubble);
        ActionManager.instance.flashForever(node: speechBubble);
    }

}
