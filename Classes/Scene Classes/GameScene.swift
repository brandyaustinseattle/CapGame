//
//  GameScene.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var loadingScene = Loading();
    
    var ouchBubble = false;

    var pathEngine = PathEngine();
    var insectEngine = InsectEngine();
    
    var player = Player();
    var isAlive = true;
    
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    let pointsBubble = Points.instance.getPointsBubble();
    
    
    override func didMove(to view: SKView) {
        initialize();
        
        self.addChild(pointsBubble);
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkPlayerBounds();
        BackGroundManager.instance.moveBGAndAddOn(scene: self);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if playerRepeatJumps >= 2 {
            return
        } else {
            playerOnPath = false;
            playerRepeatJumps += 1;
            player.jump();
        }
        player.jump();
    }
    
    func initialize() {
        physicsWorld.contactDelegate = self;
        
        BackGroundManager.instance.createBG(scene: self);
        BackGroundManager.instance.createBGAddOn(scene: self);
        
        addInstructions();
        
        createPlayer();
        playerConstraints();
        
        startTheEngines();
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

        if firstBody.node?.name == "Player" && (secondBody.node?.name == "pathItem" || secondBody.node?.name == "Rock") {
            playerOnPath = true;
            playerRepeatJumps = 0;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Insect" {
            
            Points.instance.value = 0;
            
            let label = LabelMaker(message: "\(Points.instance.value)", messageSize: 60)
            pointsBubble.updateLabel(newLabel: label)
            
            let textureOne = SKTexture(imageNamed: "roundcloud");
            let textureTwo = SKTexture(imageNamed: "grayroundcloud");
            
            ActionManager.instance.flashAltTexture(node: pointsBubble, textureOne: textureOne, textureTwo: textureTwo);
            
            player.getDizzy();
            
            secondBody.node?.removeFromParent()
            
            if ouchBubble == false {
                self.addOuchBubble();
                ouchBubble = true;
            }
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Drink" {
            
            if Points.instance.value == 0 {
                self.addPlusBubble();
            }
            
            let consumableName = secondBody.node?.name;
            Points.instance.increment(consumableName: consumableName!);
            
            let label = LabelMaker(message: "\(Points.instance.value)", messageSize: 60)
            pointsBubble.updateLabel(newLabel: label)
            
            let position = secondBody.node?.position;
            let cPulse = ActionManager.instance.contactPulse(position: position!);
            self.addChild(cPulse);

            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Portalstand" {
            
            pathEngine.timer.invalidate();
        
            let newScene = BonusScene(fileNamed: "BonusScene")!;
            newScene.scaleMode = .aspectFill;

            let doorway = SKTransition.doorway(withDuration: 1.5);
            
            self.view?.presentScene(newScene, transition: doorway);
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Portalplane" {
            
            pathEngine.timer.invalidate();
            
            loadingScene.setSceneOption();
            
            let newScene = GameScene(fileNamed: "GameScene")!;
            newScene.scaleMode = .aspectFill;
            
            let doorway = SKTransition.doorway(withDuration: 1.5);
            
            self.view?.presentScene(newScene, transition: doorway);
        }
    }
    
    func startTheEngines() {
        pathEngine.initialize(scene: self);
        insectEngine.initialize(scene: self);
    }
    
    func createPlayer() {
        player = Player(imageNamed: "standing1");
        player.initialize();
        player.position = CGPoint(x: -500, y: 200);
        
        self.addChild(player);
        
        player.runFast();
    }
    
    func playerConstraints() {
        let yRange = SKRange(lowerLimit: -1000, upperLimit: size.height/2 - 100);
        player.constraints = [SKConstraint.positionY(yRange)];
    }
    
    func checkPlayerBounds() {
        if player.position.x < -(self.frame.size.width/2 ) || player.position.y < -(self.frame.size.height/2) {
            playerDied();
        }
    }

    func playerDied() {
        
        let gameOverScene = GameOverScene(fileNamed: "GameOverScene")!;
        gameOverScene.scaleMode = .aspectFill;
        
        let doorway = SKTransition.doorway(withDuration: 3);
        
        doorway.pausesIncomingScene = true;

        self.view?.presentScene(gameOverScene, transition: doorway);
    }
    
    // also in bonus scene
    func addPlusBubble() {
        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);
        let label = LabelMaker(message: "+1", messageSize: 175)
        let plus = Bubble(type: "boltspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(plus);
        ActionManager.instance.removeAfter(node: plus, seconds: 1.5);
    }
    
    // similar to other add bubble functions
    func addOuchBubble() {
        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);
        let label = LabelMaker(message: "ouch", messageSize: 150)
        let ouch = Bubble(type: "curvyspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(ouch);
        ActionManager.instance.removeAfter(node: ouch, seconds: 1.5);
    }
    
    
    
    
    
    // move instructions to instructions manager and call functions separately based on what appears on the screen
    func addInstructions() {
    
        let label1 = LabelMaker(message: "tap to jump", messageSize: 55)
        let label2 = LabelMaker(message: "tap in air to double jump", messageSize: 55);
        let label3 = LabelMaker(message: "grab drinks to rack up points", messageSize: 55);
        let label4 = LabelMaker(message: "...but avoid the insects who sting", messageSize: 55);
        let label5 = LabelMaker(message: "visit the stand to enter bonus level", messageSize: 55);
        let label6 = LabelMaker(message: "catch the plane to travel to another place", messageSize: 55);
       
        let position = CGPoint(x: 0, y: frame.size.height/2 - 75);
        
        let cloud1 = Bubble(type: "instructionscloud", scale: 1, bubblePosition: position, label: label1, zPos: 2)
        let cloud2 = Bubble(type: "instructionscloud", scale: 1, bubblePosition: position, label: label2, zPos: 2)
        let cloud3 = Bubble(type: "instructionscloud", scale: 1, bubblePosition: position, label: label3, zPos: 2)
        let cloud4 = Bubble(type: "instructionscloud", scale: 1, bubblePosition: position, label: label4, zPos: 2)
        let cloud5 = Bubble(type: "instructionscloud", scale: 1, bubblePosition: position, label: label5, zPos: 2)
        let cloud6 = Bubble(type: "instructionscloud", scale: 1, bubblePosition: position, label: label6, zPos: 2)


        delay(time: 0) {
            self.addChild(cloud1);
            ActionManager.instance.removeAfter(node: cloud1, seconds: 5);
        }
        
        delay(time: 10) {
            self.addChild(cloud2);
            ActionManager.instance.removeAfter(node: cloud2, seconds: 5);
        }

        delay(time: 16) {
            self.addChild(cloud3);
            ActionManager.instance.removeAfter(node: cloud3, seconds: 5);
        }

        delay(time: 22) {
            self.addChild(cloud4);
            ActionManager.instance.removeAfter(node: cloud4, seconds: 5);
        }

        delay(time: 27) {
            self.addChild(cloud5);
            ActionManager.instance.removeAfter(node: cloud5, seconds: 5);
        }

        delay(time: 32) {
            self.addChild(cloud6);
            ActionManager.instance.removeAfter(node: cloud6, seconds: 5);
        }
    }
    
}
