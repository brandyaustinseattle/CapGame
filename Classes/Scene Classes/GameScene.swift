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
    
    var playerSpeaking = false;
    
    var ouchBubble = false;

    var pathEngine = PathEngine();
    var insectEngine = InsectEngine();
    
    var player = Player();
    var isAlive = true;
    
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    let pointsBubble = PointsController.instance.getPointsBubble();

    
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
            
            PointsController.instance.points = 0;
            
            let label = LabelMaker(message: "\(PointsController.instance.points)", messageSize: 60)
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
            
            if PointsController.instance.points == 0 {
                self.addPlusBubble();
            }
            
            let consumableName = secondBody.node?.name;
            PointsController.instance.increment(consumableName: consumableName!);
            
            let label = LabelMaker(message: "\(PointsController.instance.points)", messageSize: 60)
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
        player.position = CGPoint(x: -500, y: 0);
        
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
        
        pathEngine.timer.invalidate();
        
        if GameManager.instance.getEasyDifficulty() {
            let highscore = GameManager.instance.getEasyDifficultyScore();
            
            if highscore < Int32(PointsController.instance.points) {
                GameManager.instance.setEasyDifficultyScore(Int32(PointsController.instance.points));
            }
            
        } else if GameManager.instance.getMediumDifficulty() {
            let highscore = GameManager.instance.getMediumDifficultyScore();
            
            if highscore < Int32(PointsController.instance.points) {
                GameManager.instance.setMediumDifficultyScore(Int32(PointsController.instance.points));
            }
            
        } else if GameManager.instance.getHardDifficulty() {
            let highscore = GameManager.instance.getHardDifficultyScore();
            
            if highscore < Int32(PointsController.instance.points) {
                GameManager.instance.setHardDifficultyScore(Int32(PointsController.instance.points));
            }
            
        }
        
        GameManager.instance.saveData();
        
        let gameOverScene = GameOverScene(fileNamed: "GameOverScene")!;
        transitionScenes(oldScene: self, newScene: gameOverScene)
    }
        
    func addPlusBubble() {
        if playerSpeaking {return};
        
        playerSpeaking = true;

        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);
        let label = LabelMaker(message: "+1", messageSize: 175)
        let plus = Bubble(type: "boltspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(plus);
        ActionManager.instance.removeAfter(node: plus, seconds: 1.5);
        
        delay(time: 2) {
            self.playerSpeaking = false;
        }
    }
    
    func addOuchBubble() {
        if playerSpeaking {
            ouchBubble = false;
            return;
        }
        
        playerSpeaking = true;
        
        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);
        let label = LabelMaker(message: "ouch", messageSize: 150)
        let ouch = Bubble(type: "curvyspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(ouch);
        ActionManager.instance.removeAfter(node: ouch, seconds: 1.5);
        
        delay(time: 2) {
            self.playerSpeaking = false;
        }
    }

}
