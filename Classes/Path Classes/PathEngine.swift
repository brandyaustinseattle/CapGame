//
//  PathEngine.swift
//  CapGame
//
//  Created by Brandy Austin on 7/9/18.
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


class PathEngine {

    let pathImages = ["startLow", "startStep", "middleLow", "endLow", "aloneLow", "startHigh", "middleHigh", "endHigh", "aloneHigh"];
    var pathItem = PathItem();
    
    var spaceBefore = Int();
    
    var type = String();
    var height = String();
    var lastType = String();
    var lastHeight = String();
    
    func initialize(gameScene: GameScene) {
        
        createRunway(gameScene: gameScene);
        
        Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createMainPath), userInfo: gameScene, repeats: true);
    }

    func createRunway(gameScene: GameScene) {
        
        for _ in 0...2 {
            
            pathItem = PathItem(imageNamed: "middleLow");
            pathItem.initialize();
            
            pathItem.addPathItem(gameScene: gameScene, spaceBefore: Int(0), drinkFlag: false);
            
        };
        
        pathItem = PathItem(imageNamed: "endLow");
        pathItem.initialize();
        
        pathItem.addPathItem(gameScene: gameScene, spaceBefore: Int(0), drinkFlag: false);
        
        lastType = "end";
        lastHeight = "Low";
    }
    
    @objc func createMainPath(timer: Timer) {
        
        let gameScene = timer.userInfo as! GameScene;
        
        let startAloneFactor = 4;
        let lowMiddleEndFactor = 6;
        let highMiddleEndFactor = 5;
        let lowHighFactor = 6;
        
        
        let randomOne = Int.random(min: 1, max: 10);
        let randomTwo = Int.random(min: 1, max: 10);
        
        let drinkFlag = drinkRequired(pathItem: pathItem);
        
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
        
        pathItem = PathItem(imageNamed: "\(type)\(height)");
        pathItem.initialize();
        
        
        pathItem.addPathItem(gameScene: gameScene, spaceBefore: spaceBefore, drinkFlag: drinkFlag);
        
        lastType = type;
        lastHeight = height;
    }
    
    func drinkRequired(pathItem: PathItem) -> Bool {
        
        if pathItem.name != "startStep" {
            let drinkFactor = 3;
            let randomDrink = Int.random(min: 1, max: 10);

            return randomDrink <= drinkFactor
        } else {
            return false
        }
    }

}
