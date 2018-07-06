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
        precondition(min <= max);
        let randomizer = GKRandomSource.sharedRandom();
        return min + randomizer.nextInt(upperBound: max - min + 1);
    }
}




class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = Player();
    var playerOnPath = false;
    var playerRepeatJumps = 0;
    
    var pathOptions = [SKSpriteNode]();
    var xValue = CGFloat(-675.0);
    
    override func update(_ currentTime: TimeInterval) {
        moveMountains();
    }
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        if playerRepeatJumps >= 2 {
//            return
//        } else {
//            playerOnPath = false;
//            playerRepeatJumps += 1;
//            player.jump();
//        }
        player.jump();
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

        createPathOptions();
        
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
    
    func setConstraints() {
        let yRange = SKRange(lowerLimit: -(size.width/2), upperLimit: size.height/2 - 100);
        player.constraints = [SKConstraint.positionY(yRange)];
    }
    

    func createPathOptions() {
        
        let lowLeftEdge = SKSpriteNode(imageNamed: "left-edge-pink");
        lowLeftEdge.name = "lowLeftEdge";

        let lowAddOn = SKSpriteNode(imageNamed: "low-add-on");
        lowAddOn.name = "lowAddOn";
        
        let lowRightEdge = SKSpriteNode(imageNamed: "right-edge-pink");
        lowRightEdge.name = "lowRightEdge";
        
        let stepLeftEdge = SKSpriteNode(imageNamed: "step-edge");
        stepLeftEdge.name = "stepLeftEdge";
        
        let midAlone = SKSpriteNode(imageNamed: "mid-edge-pink");
        midAlone.name = "midAlone";
        
        let tallAlone = SKSpriteNode(imageNamed: "tall-edge");
        tallAlone.name = "tallAlone";
        
        let tallLeftEdge = SKSpriteNode(imageNamed: "tall-left");
        tallLeftEdge.name = "tallLeftEdge";
        
        let tallAddOn = SKSpriteNode(imageNamed: "tall-add-on");
        tallAddOn.name = "tallAddOn";
        
        let tallRightEdge = SKSpriteNode(imageNamed: "tall-right");
        tallRightEdge.name = "tallRightEdge";
        
        pathOptions.append(contentsOf: [lowLeftEdge, lowAddOn, lowRightEdge, stepLeftEdge, midAlone, tallAlone, tallLeftEdge, tallAddOn, tallRightEdge]);
    
        setPathPhysics();
    }
    
    func setPathPhysics() {
        for pathItem in pathOptions {

            pathItem.physicsBody = SKPhysicsBody(texture: pathItem.texture!, size: pathItem.texture!.size());
            pathItem.physicsBody?.affectedByGravity = false;
            pathItem.physicsBody?.isDynamic = false;
            pathItem.physicsBody?.categoryBitMask = PhysicsCategory.Ground;
        }
    }
    
    func addPathItem(pathItem: SKSpriteNode) {
        
        pathItem.setScale(0.55);
        pathItem.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pathItem.position = CGPoint(x: CGFloat(xValue), y: -(frame.size.height/2) + (pathItem.size.height * 0.55/2));
        pathItem.zPosition = 2;
        
        let incrementAmt = CGFloat(pathItem.size.width);
        
        xValue += incrementAmt;
        
        let move = SKAction.moveTo(x: -(self.frame.size.width * 2), duration: TimeInterval(40));
        let remove = SKAction.removeFromParent();
        
        let sequence = SKAction.sequence([move, remove]);
        
        pathItem.run(sequence);
        
        self.addChild(pathItem);
    }
    
    func createRunway() {
        for _ in 0...2 {
            let index = pathOptions.index(where: {$0.name == "lowAddOn"})!;
            let item = pathOptions[index].copy() as! SKSpriteNode;
            addPathItem(pathItem: item);
        };
        
        let index = pathOptions.index(where: {$0.name == "lowRightEdge"})!;
        let item = pathOptions[index].copy() as! SKSpriteNode;
        addPathItem(pathItem: item);
    }
    
    @objc func createMainPath() {
        let index = Int.random(min: 0, max: pathOptions.count - 1);
        let item = pathOptions[index].copy() as! SKSpriteNode;
        addPathItem(pathItem: item);
    }
    
}
