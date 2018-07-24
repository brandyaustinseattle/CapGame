//
//  BonusScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/12/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit
import GameplayKit


class BonusScene: SKScene, SKPhysicsContactDelegate {
    
    let pointsBubble = Points.instance.getPointsBubble();
    var plusFiveBubble = false;
    
    var countDownValue = 10;
    
    var touchLocation = CGPoint();
    
    var player = Player();
    var drink = Consumable();
    var bonus = Consumable();
    
    var timer = Timer();
    
    
    let countDownBubble = Bubble(type: "longcloud", scale: 0.85, bubblePosition: CGPoint(x: 0, y: 235), label: LabelMaker(message: "\(10)", messageSize: 65));
    
    
    override func didMove(to view: SKView) {
        initialize();
        
        self.addChild(pointsBubble);
        self.addChild(countDownBubble);
    }
    
    override func update(_ currentTime: TimeInterval) {
        if countDownValue == 0 {
            timer.invalidate();
            self.exitScene();
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer  = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(countDownSeconds), userInfo: nil, repeats: true);
        
        guard let touch = touches.first else { return }
        let destination = touch.location(in: self)
        let move = SKAction.move(to: destination, duration: 2)
        player.removeAction(forKey: "move")
        player.run(move, withKey: "move")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAction(forKey: "move");
    }

    @objc func countDownSeconds() {
        if countDownValue == 0 {
            return
        }
        
        countDownValue -= 1;
        
        let textureOne = SKTexture(imageNamed: "longcloud");
        let textureTwo = SKTexture(imageNamed: "graylongcloud");
        
        ActionManager.instance.flashAltTexture(node: countDownBubble, textureOne: textureOne, textureTwo: textureTwo);
        
        let label = LabelMaker(message: "\(countDownValue)", messageSize: 65);
        countDownBubble.updateLabel(newLabel: label);
    }
    
    // same as drink portion of didBegin in GameScene
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

        if firstBody.node?.name == "Player" && secondBody.node?.name == "Drink" || secondBody.node?.name == "Bonus" {
            
            let consumableName = secondBody.node?.name;
            
            if let child = self.childNode(withName: "roundspeech") as? SKSpriteNode {
                child.removeFromParent()
            }
            
            Points.instance.increment(consumableName: consumableName!);
      
            let label = LabelMaker(message: "\(Points.instance.value)", messageSize: 60)
            pointsBubble.updateLabel(newLabel: label)
            
            let position = secondBody.node?.position;
            let cPulse = ActionManager.instance.contactPulse(position: position!);
            self.addChild(cPulse);
            
            secondBody.node?.removeFromParent();
        
        }
        
        if plusFiveBubble == false && firstBody.node?.name == "Player" && secondBody.node?.name == "Bonus" {
            self.addPlusBubble();
        }

    }
    
    func exitScene() {
        let newScene = GameScene(fileNamed: "GameScene")!;
        newScene.scaleMode = .aspectFill;
        
        let doorway = SKTransition.doorway(withDuration: 1.5);
        
        self.view?.presentScene(newScene, transition: doorway);
    }

    
    func initialize() {
        physicsWorld.contactDelegate = self;

        BackGroundManager.instance.createBG(scene: self, dynamic: false);
        createClouds();
        moveClouds();
        
        createPlayer();
        addConsumablesMatrix();
        
        addQuickBubble();
    }
    
    func createClouds() {
        
        let cloudSizeArray = [CGFloat(0.55), CGFloat(0.8), CGFloat(1.05)];
        
        var x = CGFloat(self.frame.size.width/2);
        var y = CGFloat(self.frame.size.height/2 - (self.frame.size.height/4));
        
        for _ in 1...2 {
            let cloud = SKSpriteNode(imageNamed: "cloud");
            cloud.name = "cloud";
            cloud.anchorPoint = CGPoint(x: 0.5, y: 0.5);
            
            // used to randomly determine x position of clouds
            let offsetXValue = Int.random(min: 100, max: 500);
            x -= CGFloat(offsetXValue);

            cloud.position = CGPoint(x: x, y: y);
            cloud.zPosition = 1;
            
            // used to randomly determine size of clouds
            let cloudSizeRandom = Int.random(min: 0, max: 2);
            let cloudSize = cloudSizeArray[cloudSizeRandom];
            cloud.setScale(cloudSize);
            
            self.addChild(cloud);
            
            // used to randomly determine y position of clouds
            let offsetYValue = Int.random(min: 30, max: 80);
            y -= CGFloat(offsetYValue);
        }
    }
    
    // same as move background function in GameScene
    func moveClouds() {
        
        enumerateChildNodes(withName: "cloud") {
            node, _ in
            
            let cloudsNode = node as! SKSpriteNode;
            
            cloudsNode.position.x -= 0.5;
            
            // less than because clouds are scrolling left
            if cloudsNode.position.x < -(self.frame.size.width) {
                cloudsNode.position.x += self.frame.size.width * 2;
            }
        };
    }
    
    func createPlayer() {
        player = Player(imageNamed: "flying1");
        player.initialize();
        
        let x = CGFloat(-(self.frame.size.width/2) + self.frame.size.width/6);
        let y = CGFloat(self.frame.size.height/2 - 3.25 * (self.frame.size.height/4));
        
        player.position = CGPoint(x: x, y: y);
        
        self.addChild(player);
        player.fly();
    }
    
    func addConsumablesMatrix() {
        
        var x = CGFloat(-(self.frame.size.width/2) + self.frame.size.width/6);
        var y = CGFloat(self.frame.size.height/2 - 2 * self.frame.size.height/6);
        
        
        // 3 rows and 5 columns of drinks/bonuses
        for i in 1...3 {
            for j in 1...5 {
                
                if (i == 3 && j == 1) {
                    // do nothing bc player will be in this area
                } else {
        
                    drink = Consumable(imageNamed: "\(option)drink");
                    bonus = Consumable(imageNamed: "\(option)bonus");
        
                    let referencePosition = CGPoint(x: x, y: y);
            
                    drink.initialize(referencePosition: referencePosition, offsetYValue: CGFloat(0), type: "Drink");
                    bonus.initialize(referencePosition: referencePosition, offsetYValue: CGFloat(0), type: "Bonus");
                    
                    let bonusRandom = Int.random(min: 1, max: 10);
                    
                    if bonusRandom <= DifficultyManager.instance.bonusFactor {
                        self.addChild(bonus);
                    } else {
                        self.addChild(drink);
                    };
                }
                
                x += self.frame.size.width/6;
            }
            
            y -= (self.frame.size.height/2 - self.frame.size.height/4);
            x = (-(self.frame.size.width/2) + self.frame.size.width/6);
        };
    }
    
    func addQuickBubble() {
        let position = CGPoint(x: player.position.x - 125, y: player.position.y + 185);
        let label = LabelMaker(message: "quick", messageSize: 75)
        let quick = Bubble(type: "roundspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(quick);
    }
    
    
    // also in game scene
    func addPlusBubble() {
        let position = CGPoint(x: player.position.x + 185, y: player.position.y + 50);
        let label = LabelMaker(message: "+5", messageSize: 175)
        let plus = Bubble(type: "boltspeech", scale: 0.45, bubblePosition: position, label: label)
        
        self.addChild(plus);
        
        ActionManager.instance.removeAfter(node: plus, seconds: 1)
        plusFiveBubble = true;
    }

    
}
