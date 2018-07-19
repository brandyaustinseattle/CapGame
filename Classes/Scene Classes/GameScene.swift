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
    
    var pointsLabel = SKLabelNode();
    var pointsBG = SKSpriteNode();


    var beeEngine = BeeEngine();
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
//        checkPlayerBounds();
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
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Bee" {
            
            Points.instance.value = 0;
            Points.instance.updatePointsDisplay(background: pointsBG, pointsLabel: pointsLabel)
            
            player.getDizzy();
            
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Drink" {
            
            if Points.instance.value == 0 {
                self.addFivePoints();
            }
            
            let objectName = secondBody.node?.name;
            Points.instance.increment(objectName: objectName!);
            Points.instance.updatePointsDisplay(background: pointsBG, pointsLabel: pointsLabel)

            let position = secondBody.node?.position;
            let cPulse = contactPulse(position: position!);
            self.addChild(cPulse);

            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Stand" {
            
            pathEngine.timer.invalidate();
        
            let newScene = BonusScene(fileNamed: "BonusScene")!;
            // needed to make images appropriate sizes
            newScene.scaleMode = .aspectFill;

            let doorway = SKTransition.doorway(withDuration: 1.5);
            
            self.view?.presentScene(newScene, transition: doorway)
        }
    }
    
    
    func initialize() {
        physicsWorld.contactDelegate = self;

        createMountains();
        createTrees();

        createPlayer();
        playerConstraints();

        startPathEngine();
    }
    
    func startPathEngine() {
        // player must be running when engine is started
        player.runFast();
        
        pathEngine.initialize(scene: self);
        beeEngine.initialize(scene: self);
    }
    
    func createMountains() {
        for i in 0...1 {
            let mountains = SKSpriteNode(imageNamed: "mountains");
            mountains.name = "mountains";
            mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            mountains.position = CGPoint(x: CGFloat(i) * mountains.size.width, y:0);
            mountains.zPosition = 0;
            self.addChild(mountains);
        }
    }
    
    func moveMountains() {
        
        enumerateChildNodes(withName: "mountains") {
            node, _ in
            
            let mountainsNode = node as! SKSpriteNode;
            
            mountainsNode.position.x -= 8;
            
            // less than because mountains are scrolling left
            if mountainsNode.position.x < -(mountainsNode.size.width) {
                mountainsNode.position.x += mountainsNode.size.width * 2;
            }
        };
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
        
        let crossFade = SKTransition.crossFade(withDuration: 0.85);
        
        self.view?.presentScene(gameOverScene, transition: crossFade);
    }
    
    func addFivePoints() {

        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);

        let label = LabelMaker(message: "+5", messageSize: 175)

        let plusFivePoints = Bubble(scene: self, type: "boltspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(plusFivePoints);
        plusFivePoints.removeAfter(seconds: 1.5);
    }
    
}
