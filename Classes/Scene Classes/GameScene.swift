//
//  GameScene.swift
//  CapGame
//
//  Created by Brandy Austin on 6/26/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


extension Int {
    static func random(min: Int, max: Int) -> Int {
        precondition(min <= max)
        let randomizer = GKRandomSource.sharedRandom()
        return min + randomizer.nextInt(upperBound: max - min + 1)
    }
}




class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    
    let lowLeftEdge = SKSpriteNode(imageNamed: "left-edge-pink");
    let lowAddOn = SKSpriteNode(imageNamed: "low-add-on");
    let lowRightEdge = SKSpriteNode(imageNamed: "right-edge-pink");
    
    let stepLeftEdge = SKSpriteNode(imageNamed: "step-edge");
    
    let midAlone = SKSpriteNode(imageNamed: "mid-edge-pink");
    let tallAlone = SKSpriteNode(imageNamed: "tall-edge");
    
    let tallLeftEdge = SKSpriteNode(imageNamed: "tall-left");
    
    let tallAddOn = SKSpriteNode(imageNamed: "tall-add-on");
    let tallRightEdge = SKSpriteNode(imageNamed: "tall-right");
    
    
    
    var player = Player();
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    var pathOptions = [SKSpriteNode]();

    
    override func update(_ currentTime: TimeInterval) {
        moveMountains();
//        movePath();
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
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        // maker sure first body is player if player is present
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        for pathItem in pathOptions {
            if firstBody.node?.name == "Player" && secondBody.node?.name == pathItem.name {
                playerOnPath = true;
                playerRepeatJumps = 0;
            }
        }
    }
    
    
    func initialize() {
        physicsWorld.contactDelegate = self;
        
        createPlayer();
        setConstraints();

        createMountains();
        createTrees();
        createPath();
        

        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(createPath), userInfo: nil, repeats: true);
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
    
    func setConstraints() {
        let yRange = SKRange(lowerLimit: -(size.width/2), upperLimit: size.height/2 - 100);
        player.constraints = [SKConstraint.positionY(yRange)];
    }
    
    
    
    
    
    var i = CGFloat(-675.0);
    
    
    @objc func createPath() {
        
        pathOptions.append(contentsOf: [lowLeftEdge, lowAddOn, lowRightEdge, stepLeftEdge, midAlone, tallAlone, tallLeftEdge, tallAddOn, tallRightEdge]);

        let index = Int.random(min: 0, max: pathOptions.count - 1);
        let pathItem = pathOptions[index].copy() as! SKSpriteNode;
        
        pathItem.name = "\(pathItem)";
        
        
        pathItem.physicsBody = SKPhysicsBody(texture: pathItem.texture!, size: pathItem.texture!.size());
        pathItem.setScale(0.55);

        pathItem.physicsBody?.affectedByGravity = false;
        pathItem.physicsBody?.isDynamic = false;
        pathItem.physicsBody?.categoryBitMask = PhysicsCategory.Ground;
        
        pathItem.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pathItem.position = CGPoint(x: CGFloat(i), y: -(frame.size.height/2) + (pathItem.size.height * 0.55/2));
        pathItem.zPosition = 3;

        
        let increment = CGFloat(pathItem.size.width);


        i += increment;
        
        let move = SKAction.moveTo(x: -(self.frame.size.width * 2), duration: TimeInterval(40));
        let remove = SKAction.removeFromParent();
        
        let sequence = SKAction.sequence([move, remove]);
        
        pathItem.run(sequence);
        
        self.addChild(pathItem);
    }
    
//    func movePath() {
//
//        enumerateChildNodes(withName: "lowAddOn") {
//            node, _ in
//
//            let lowAddOnNode = node as! SKSpriteNode;
//
//            lowAddOnNode.position.x -= 15;
//
//        };
//    }

    
    
//    func createPath() {
//
//        let lowLeftEdge = SKSpriteNode(imageNamed: "left-edge-pink");
//        let lowAddOn = SKSpriteNode(imageNamed: "low-add-on");
//        let lowRightEdge = SKSpriteNode(imageNamed: "right-edge-pink");
//
//        let stepLeftEdge = SKSpriteNode(imageNamed: "step-edge");
//
//        let midAlone = SKSpriteNode(imageNamed: "mid-edge-pink");
//        let tallAlone = SKSpriteNode(imageNamed: "tall-edge");
//
//        let tallLeftEdge = SKSpriteNode(imageNamed: "tall-left");
//
//        let tallAddOn = SKSpriteNode(imageNamed: "tall-add-on");
//        let tallRightEdge = SKSpriteNode(imageNamed: "tall-right");
//
//
//        pathOptions.append(contentsOf: [lowLeftEdge, lowAddOn, lowRightEdge, stepLeftEdge, midAlone, tallAlone, tallLeftEdge, tallAddOn, tallRightEdge]);


////        var xValue = CGFloat(lowAddOn.size.width * 0);
//
//
//        for pathItem in pathOptions {
//
//            pathItem.name = "\(pathItem)";
//            pathItem.anchorPoint = CGPoint(x: 0.5, y: 0.5);
//
////            pathItem.position = CGPoint(x: -(frame.size.width/2) + (pathItem.size.width * 0.55/2) + 500, y: -(frame.size.height/2) + (pathItem.size.height * 0.55/2));
//
//            pathItem.zPosition = 3;
//            pathItem.setScale(0.55);
//
//            pathItem.physicsBody = SKPhysicsBody(rectangleOf: pathItem.size);
//            pathItem.physicsBody?.affectedByGravity = false;
//            pathItem.physicsBody?.isDynamic = false;
//            pathItem.physicsBody?.categoryBitMask = PhysicsCategory.Ground;
//
////            self.addChild(pathItem);
////
////            xValue += CGFloat(pathItem.size.width * 1.5);

//        };
//    }
    
    
    
//    @objc func movePath() {
//
//        let xValue = Int.random(min: -100, max: 600);
//
//
//        let index = Int.random(min: 0, max: pathOptions.count - 1);
//        let pathItem = pathOptions[index].copy() as! SKSpriteNode;
//
//
//        pathItem.name = "\(pathItem)";
//        pathItem.anchorPoint = CGPoint(x: 0.5, y: 0.5);
//
//        pathItem.position = CGPoint(x: CGFloat(xValue), y: -(frame.size.height/2) + (pathItem.size.height * 0.55/2));
//
//
//        pathItem.zPosition = 3;
//        pathItem.setScale(0.55);
//
//        pathItem.physicsBody = SKPhysicsBody(rectangleOf: pathItem.size);
//        pathItem.physicsBody?.affectedByGravity = false;
//        pathItem.physicsBody?.isDynamic = false;
//        pathItem.physicsBody?.categoryBitMask = PhysicsCategory.Ground;
//
//
//
//        let move = SKAction.moveTo(x: -(self.frame.size.width * 2), duration: TimeInterval(55));
//        let remove = SKAction.removeFromParent();
//
//        let sequence = SKAction.sequence([move, remove]);
//
//        pathItem.run(sequence);
//
//        self.addChild(pathItem);
//
//    }
    
}
