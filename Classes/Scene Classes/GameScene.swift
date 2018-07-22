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
    
    var pointsLabel = SKLabelNode();
    var pointsBG = SKSpriteNode();
    var ouchBubble = false;

    var insectEngine = InsectEngine();
    var pathEngine = PathEngine();
    
    var player = Player();
    var isAlive = true;
    
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    
    
    override func didMove(to view: SKView) {
        initialize();
        
        pointsBG = Points.instance.getBackground();
        pointsLabel = Points.instance.getLabel();
        
        Points.instance.updatePointsDisplay(background: pointsBG, pointsLabel: pointsLabel)
        self.addChild(pointsBG);
        self.addChild(pointsLabel);
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkPlayerBounds();
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

        if firstBody.node?.name == "Player" && secondBody.node?.name == "pathItem" || secondBody.node?.name == "Rock" {
            playerOnPath = true;
            playerRepeatJumps = 0;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Insect" {
            
            Points.instance.value = 0;
            Points.instance.updatePointsDisplay(background: pointsBG, pointsLabel: pointsLabel)
            
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
            Points.instance.updatePointsDisplay(background: pointsBG, pointsLabel: pointsLabel)

            let position = secondBody.node?.position;
            let cPulse = contactPulse(position: position!);
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
    
    
    func initialize() {
        physicsWorld.contactDelegate = self;

        createBG();
        moveBG();
        createBGAddOn();
        addInstructionsBubble();

        createPlayer();
        playerConstraints();

        startPathEngine();
    }
    
    func startPathEngine() {
        // player must be running when engine is started
        player.runFast();
        
        pathEngine.initialize(scene: self);
        insectEngine.initialize(scene: self);
    }
    
    func createBG() {
        for i in 0...1 {
            let background = SKSpriteNode(imageNamed: "\(option)background");
            background.name = "background";
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            background.position = CGPoint(x: CGFloat(i) * background.size.width, y:0);
            background.zPosition = 0;
            self.addChild(background);
            
            if option == "C" {
                let snow = snowPulse(position: self.position);
                self.addChild(snow);
            }
        }
    }
    
    func moveBG() {
        
        enumerateChildNodes(withName: "background") {
            node, _ in
            
            let backgroundsNode = node as! SKSpriteNode;
            
            backgroundsNode.position.x -= 8;
            
            // less than because backgrounds are scrolling left
            if backgroundsNode.position.x < -(backgroundsNode.size.width) {
                backgroundsNode.position.x += backgroundsNode.size.width * 2;
            }
        };
    }
    
    func createBGAddOn() {
        let addOn = SKSpriteNode(imageNamed: "\(option)addon");
        addOn.name = "addOn";
        addOn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        addOn.position = CGPoint(x: 0, y:0);
        addOn.zPosition = 1;
        addOn.setScale(0.70);
        self.addChild(addOn);
    }
    
    func createPlayer() {
        player = Player(imageNamed: "standing1");
        player.initialize();
        player.position = CGPoint(x: -500, y: 200);
        
        self.addChild(player);
    }
    
    func playerConstraints() {
//        let xRange = SKRange(lowerLimit: -(size.width/2) + 25, upperLimit: size.width/2);
        let yRange = SKRange(lowerLimit: -1000, upperLimit: size.height/2 - 100);
//        player.constraints = [SKConstraint.positionX(xRange)];
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

        self.view?.presentScene(gameOverScene, transition: doorway);
    }
    
    // also in bonus scene
    func addPlusBubble() {

        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);

        let label = LabelMaker(message: "+1", messageSize: 175)

        let plus = Bubble(scene: self, type: "boltspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(plus);
        plus.removeAfter(seconds: 1.5);
    }
    
    // similar to other add bubble functions
    func addOuchBubble() {
        
        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);
        
        let label = LabelMaker(message: "ouch", messageSize: 150)
        
        let plus = Bubble(scene: self, type: "curvyspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(plus);
        plus.removeAfter(seconds: 1.5);
    }

    
    
    func addInstructions() {
//        let label1 = LabelMaker(message: "tap to jump", messageSize: 55)
//        let label2 = LabelMaker(message: "tap while in air to double jump", messageSize: 55);
//        let label3 = LabelMaker(message: "get the drinks to rack up points", messageSize: 55);
//        let label4 = LabelMaker(message: "...but avoid the insects who sting", messageSize: 55);
//        let label5 = LabelMaker(message: "go to the stand to enter bonus level", messageSize: 55);
//        let label6 = LabelMaker(message: "go to the plane to travel to another place", messageSize: 55);
        
//        let label = LabelMaker(message: "tap to jump...tap in air to double jump...get the drinks to rack up points...but avoid the insects who sting", messageSize: 55)
    }
    
    func addInstructionsBubble() {
        
        let position = CGPoint(x: 0, y: frame.size.height/2 - 75);
        
        let label = LabelMaker(message: "tap to jump...tap in air to double jump...get the drinks to rack up points...", messageSize: 55)
        
        label.scrollLabel();
        
        let cloud = Bubble(scene: self, type: "instructionscloud", scale: 1, bubblePosition: position, label: label, zPos: 2)
        
        self.addChild(cloud);
    }
}
