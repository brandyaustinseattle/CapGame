//
//  PathEngine.swift
//  CapGame
//
//  Created by Brandy Austin on 7/9/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class PathEngine {
    
    var stand = Stand();

    let pathImages = ["startLow", "startStep", "middleLow", "endLow", "aloneLow", "startHigh", "middleHigh", "endHigh", "aloneHigh"];
    var pathItem = PathItem();
    
    var spaceBefore = Int();
    
    var type = String();
    var height = String();
    var lastType = String();
    var lastHeight = String();
        
    func initialize(gameScene: SKScene) {
        
        createRunway(gameScene: gameScene);
        
        Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createMainPath), userInfo: gameScene, repeats: true);
    }

    func createRunway(gameScene: SKScene) {
        
        for _ in 0...2 {
            
            pathItem = PathItem(imageNamed: "middleLow");
            pathItem.initialize();
            
            pathItem.addPathItem(scene: gameScene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
            
        };
        
        pathItem = PathItem(imageNamed: "endLow");
        pathItem.initialize();
        
        pathItem.addPathItem(scene: gameScene, spaceBefore: Int(0), drinkFlag: false, rockFlag: false);
        
        lastType = "end";
        lastHeight = "Low";
    }
    
    @objc func createMainPath(timer: Timer) {

        let gameScene = timer.userInfo as! GameScene;
        
        let standFactor = 5;
        let startAloneFactor = 4;
        let lowMiddleEndFactor = 6;
        let highMiddleEndFactor = 5;
        let lowHighFactor = 6;
        
        let standRandom = Int.random(min: 1, max: 10);
        let randomOne = Int.random(min: 1, max: 10);
        let randomTwo = Int.random(min: 1, max: 10);
        
        if standRandom <= standFactor {
            insertStand(gameScene: gameScene);
            return;
        }
        
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
            spaceBefore = Int.random(min: 70, max: 130);
            
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
            spaceBefore = Int(0);
            
        };
        
        let drinkFlag = drinkRequired(type: type);
        let rockFlag = rockRequired(type: type);

        pathItem = PathItem(imageNamed: "\(type)\(height)");
        pathItem.initialize();
        
        pathItem.addPathItem(scene: gameScene, spaceBefore: spaceBefore, drinkFlag: drinkFlag, rockFlag: rockFlag);
        
        lastType = type;
        lastHeight = height;
    }
    
    func rockRequired(type: String) -> Bool {
        if (type != "alone" && height != "High") && height != "Step" {
            
            let rockFactor = 4;
            let rockRandom = Int.random(min: 1, max: 10);
            
            return rockRandom <= rockFactor
        } else {
            return false
        }
    }
    
    func drinkRequired(type: String) -> Bool {
        if type == "alone" || type == "middle" {
            let drinkFactor = 8;
            let drinkRandom = Int.random(min: 1, max: 10);

            return drinkRandom <= drinkFactor
        } else {
            return false
        }
    }
    
    // refactor function to use a loop and randomization
    func insertStand(gameScene: SKScene) {
    
        pathItem = PathItem(imageNamed: "startStep");
        pathItem.initialize();
        pathItem.addPathItem(scene: gameScene, spaceBefore: 100, drinkFlag: false, rockFlag: false);
       
        pathItem = PathItem(imageNamed: "middleLow");
        pathItem.initialize();
        pathItem.addPathItem(scene: gameScene, spaceBefore: 0, drinkFlag: false, rockFlag: false);
        
        pathItem = PathItem(imageNamed: "middleLow");
        pathItem.initialize();
        pathItem.addPathItem(scene: gameScene, spaceBefore: 0, drinkFlag: false, rockFlag: false);
        
        let midPathItemPosition = pathItem.position;
        
        pathItem = PathItem(imageNamed: "middleLow");
        pathItem.initialize();
        pathItem.addPathItem(scene: gameScene, spaceBefore: 0, drinkFlag: false, rockFlag: false);
        
        pathItem = PathItem(imageNamed: "endLow");
        pathItem.initialize();
        pathItem.addPathItem(scene: gameScene, spaceBefore: 0, drinkFlag: false, rockFlag: false);
        
        lastType = "end";
        lastHeight = "Low";
        
        stand = Stand(imageNamed: "stand");
        // pathItem height doesn't need to be * 0.55 bc it's already initialized
        // stand height does need * 0.5 bc it's not initialized yet
        let offsetYValue = CGFloat(pathItem.size.height / 2 + stand.size.height * 0.5 / 2);

        stand.initialize(midPathItemPosition: midPathItemPosition, offsetYValue: offsetYValue);
       
        gameScene.addChild(stand);
        self.move(itemToMove: stand);
        
    }
    
    
    
    

    
    
    // also in PathItem.swift
    func move(itemToMove: SKSpriteNode) {

        let endpoint = CGPoint(x: -800, y: itemToMove.position.y);
        let move = SKAction.move(to: endpoint, duration: getDuration(pointA: itemToMove.position, pointB: endpoint, speed: 175.0))
        
        let remove = SKAction.removeFromParent();
        let sequence = SKAction.sequence([move, remove]);
        itemToMove.run(sequence);
    }
    
    func getDuration(pointA: CGPoint, pointB: CGPoint, speed:CGFloat)->TimeInterval {
        let xDist = (pointB.x - pointA.x)
        let yDist = (pointB.y - pointA.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist));
        let duration : TimeInterval = TimeInterval(distance/speed)
        return duration
    }

}
