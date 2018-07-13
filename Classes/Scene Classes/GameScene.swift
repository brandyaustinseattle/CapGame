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
    
    let pointsLabel = SKLabelNode(fontNamed: "Marker Felt");

    var pathEngine = PathEngine();
        
    var player = Player();
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    override func didMove(to view: SKView) {
        initialize();
        
        Points.instance.updateLabel(pointsLabel: pointsLabel)
        self.addChild(pointsLabel);
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveMountains();
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

        if firstBody.node?.name == "Player" && secondBody.node?.name == "pathItem" {
            playerOnPath = true;
            playerRepeatJumps = 0;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Drink" {
            Points.instance.increment();
            Points.instance.updateLabel(pointsLabel: pointsLabel);
            
            let pulse = SKEmitterNode(fileNamed: "Drink");
            pulse?.position = (secondBody.node?.position)!;
            self.addChild(pulse!);
            
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Stand" {
            let newScene = BonusScene(fileNamed: "BonusScene")!;
            // needed to make images appropriate sizes
            newScene.scaleMode = .aspectFill

            let doorway = SKTransition.doorway(withDuration: 1.5);
            
            self.view?.presentScene(newScene, transition: doorway)
        }
    }
    
    
    func initialize() {
        physicsWorld.contactDelegate = self;
        
        createPlayer();
        playerConstraints();

        createMountains();
        createTrees();
        
        startPathEngine();
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
        player = Player(imageNamed: "testPlayer");
        player.initialize();
        player.position = CGPoint(x: -500, y: 200);
        
        self.addChild(player);
        player.runFast();
    }
    
    func playerConstraints() {
//        let xRange = SKRange(lowerLimit: -(size.width/2) + 25, upperLimit: size.width/2);
        let yRange = SKRange(lowerLimit: -1000, upperLimit: size.height/2 - 100);
//        player.constraints = [SKConstraint.positionX(xRange)];
        player.constraints = [SKConstraint.positionY(yRange)];
    }
    
    func startPathEngine() {
        pathEngine.initialize(gameScene: self);
    }
    
    
    
    // functions below are a work in progress
    func checkPlayerBounds() {
        if player.position.x < -(self.frame.size.width/2 ) || player.position.y < -(self.frame.size.height/2) {
            playerDied();
        }
    }

    func playerDied() {

    }
    
}
