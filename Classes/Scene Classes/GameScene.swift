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

    var xValue = CGFloat(0);
    
    var path = Path();
    
    var player = Player();
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    var type = String();
    var height = String();
    var lastType = String();
    var lastHeight = String();
    
    
    override func update(_ currentTime: TimeInterval) {
        moveMountains();
    }
    
    override func didMove(to view: SKView) {
        initialize();
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

        for pathItem in path.pathOptions {
            if firstBody.node?.name == "Player" && secondBody.node?.name == pathItem.name {
                playerOnPath = true;
                playerRepeatJumps = 0;
            }
        }
    }
    
    
    func initialize() {
        physicsWorld.contactDelegate = self;
        
        xValue += CGFloat(-(self.frame.size.width/2));
        
        createPlayer();
        playerConstraints();

        createMountains();
        createTrees();
        
        createRunway();
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(createMainPath), userInfo: nil, repeats: true);
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
    }
    
    func playerConstraints() {
        let yRange = SKRange(lowerLimit: -(size.width/2), upperLimit: size.height/2 - 100);
        player.constraints = [SKConstraint.positionY(yRange)];
    }
    
    
    
    
    
    func addPathItem(pathItem: SKSpriteNode) {
        
        print("PLACING PIECE AT")
        print(xValue)

        pathItem.position = CGPoint(x: CGFloat(xValue), y: -(frame.size.height/2) + (pathItem.size.height * 0.55/2));
        
        xValue += CGFloat(pathItem.size.width * 0.55 / 2);
        
        pathItem.setScale(0.55);
        
//        let endpoint = CGPoint(x: -800, y: pathItem.position.y);
//
//        let move = SKAction.move(to: endpoint, duration: getDuration(pointA: pathItem.position, pointB: endpoint, speed:150.0))
//
//        let remove = SKAction.removeFromParent();
//        let sequence = SKAction.sequence([move, remove]);
//
//        pathItem.run(sequence);
        
        self.addChild(pathItem);
    }
    
    func getDuration(pointA:CGPoint,pointB:CGPoint,speed:CGFloat)->TimeInterval {
        let xDist = (pointB.x - pointA.x)
        let yDist = (pointB.y - pointA.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist));
        let duration : TimeInterval = TimeInterval(distance/speed)
        return duration
    }
    
    func createRunway() {
        path.initialize();
        
        for _ in 0...2 {
            
            let index = path.pathOptions.index(where: {$0.name == "middleLow"})!;
            let item = path.pathOptions[index].copy() as! SKSpriteNode;
            
            xValue += CGFloat(item.size.width * 0.55 / 2);

            addPathItem(pathItem: item);
        };

        let index = path.pathOptions.index(where: {$0.name == "endLow"})!;
        let item = path.pathOptions[index].copy() as! SKSpriteNode;
        
         xValue += CGFloat(item.size.width * 0.55 / 2);
        
        addPathItem(pathItem: item);
        
        lastType = "end";
        lastHeight = "Low";
    }
    
    @objc func createMainPath() {
        
        let startAloneFactor = 4;
        let lowMiddleEndFactor = 6;
        let highMiddleEndFactor = 5;
        let lowHighFactor = 6;


        let randomOne = Int.random(min: 1, max: 10);
        let randomTwo = Int.random(min: 1, max: 10);


        if lastType == "end" || lastType == "alone" {

            if (randomOne <= startAloneFactor) {
                type = "start";

                if (randomTwo <= 2) {
                    height = "Low";

                } else if ((3...4).contains(randomTwo)) {
                    height = "High";

                } else {
                    height = "Step";

                };

            } else {
                type = "alone";

                if (randomTwo <= lowHighFactor) {
                    height = "Low";

                } else {
                    height = "High";

                };

            }


        } else if (lastHeight == "Low" || lastHeight == "Step" || lastHeight == "High") {

            if lastHeight == "Low" || lastHeight == "Step" {
                
                height = "Low";

                if (1...lowMiddleEndFactor).contains(randomTwo) {
                    type = "middle";

                } else {
                    type = "end";

                };

            } else if lastHeight == "High" {
                
                height = "High";

                if (1...highMiddleEndFactor).contains(randomTwo) {
                    type = "middle";

                } else {
                    type = "end";

                };

            }

        };
        
        let index = path.pathOptions.index(where: {$0.name == "\(type)\(height)" })!;

        let item = path.pathOptions[index].copy() as! SKSpriteNode;
        
        xValue += CGFloat(item.size.width * 0.55 / 2);
        
        addPathItem(pathItem: item);
        
        lastType = type;
        lastHeight = height;
    }
    
}
