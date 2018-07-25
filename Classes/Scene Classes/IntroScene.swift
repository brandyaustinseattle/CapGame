//
//  IntroScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class IntroScene: StaticScene {
    
    override var text : String {
        get { return "let's go" }
        set { }
    }
    
    override func setUp() {
        GameManager.instance.initializeGameData();
        
        addLevelsBubbles();
        
        super.initialize(playerImage: "standing1");
    }
    
    
    // NEED TO UPDATE SET DIFFICULTY FOR DEMO IN CODE BELOW
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        GameManager.instance.gameStartedFromMainMenu = true;
        
        let touch:UITouch = touches.first!;
        let positionInScene = touch.location(in: self);
        let touchedNode = self.atPoint(positionInScene);
        
        if touchedNode.name == "easybutton" {
            DifficultyManager.instance.setFactors(difficulty: "easy");
            setDifficulty("easy");
            
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);
        } else if touchedNode.name == "mediumbutton" {
            DifficultyManager.instance.setFactors(difficulty: "medium");
            setDifficulty("medium");
            
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);
        } else if touchedNode.name == "hardbutton" {
            DifficultyManager.instance.setFactors(difficulty: "hard");
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);
            
            setDifficulty("hard");
        } else if touchedNode.name == "demobutton" {
            DifficultyManager.instance.setFactors(difficulty: "demo");
            setDifficulty("easy");

            transitionScenes(oldScene: self, newScene: DemoGameScene(fileNamed: "DemoGameScene")!);
            speed = CGFloat(15);
        } else {
            super.managePlayerJumpsOnTouch();
        }
    }
    
    
    
    
    
    fileprivate func setDifficulty(_ difficulty: String) {
        switch(difficulty) {
        case "easy":
            GameManager.instance.setEasyDifficulty(true);
            GameManager.instance.setMediumDifficulty(false);
            GameManager.instance.setHardDifficulty(false);
            break;
            
        case "medium":
            GameManager.instance.setEasyDifficulty(false);
            GameManager.instance.setMediumDifficulty(true);
            GameManager.instance.setHardDifficulty(false);
            break;
            
        case "hard":
            GameManager.instance.setEasyDifficulty(false);
            GameManager.instance.setMediumDifficulty(false);
            GameManager.instance.setHardDifficulty(true);
            break;
            
        default:
            break;
        }
        GameManager.instance.saveData();
    }
    
    func addLevelsBubbles() {

        let difficultyTypes = ["easybutton", "mediumbutton", "hardbutton", "demobutton"];
        
        var y = self.size.height/2 - self.size.height/6 - frame.size.height;

        var time = Double(0.5);
        
        for type in difficultyTypes {

            delay(time: time) {
            
                let position = CGPoint(x: -100, y: y);

                let button = Bubble(type: "\(type)", scale: 0.75, bubblePosition: position, label: nil)

                let move = SKAction.moveBy(x: 0, y: self.frame.size.height, duration: 0.75)

                self.addChild(button);
                ActionManager.instance.rotateBackForth(node: button, denominator: 100);
                button.run(move);

                y -= self.size.height/4.5;
            }
            time += 0.5;

        }
    }
    
}
