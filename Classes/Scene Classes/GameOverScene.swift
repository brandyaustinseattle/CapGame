//
//  GameOverScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/16/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class GameOverScene: StaticScene {

    var timer = Timer();
    let pointsBubble = PointsController.instance.getPointsBubble();
        
    override var text : String {
        get { return "game over" }
        set { }
    }
    
    override func setUp() {
        
        getReference();
        setPoints();
        
        addFunctionalityBubbles();

        self.addChild(pointsBubble);
        
        super.initialize(playerImage: "standing1");
        
        delay(time: 3) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.countDownPoints), userInfo: nil, repeats: true);
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        GameManager.instance.gameStartedFromMainMenu = false;
        GameManager.instance.gameRestartedPlayerDied = true;
        
        let touch:UITouch = touches.first!;
        let positionInScene = touch.location(in: self);
        let touchedNode = self.atPoint(positionInScene);
        
        if touchedNode.name == "home" {
            transitionScenes(oldScene: self, newScene: IntroScene(fileNamed: "IntroScene")!);
            
        } else if touchedNode.name == "replay" {
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);
            PointsController.instance.points = 0;
            
        } else {
            super.managePlayerJumpsOnTouch();
        }
    }
    
    @objc func countDownPoints() {
        
        if PointsController.instance.points == 0 {
            timer.invalidate();
            return
        }
        
        PointsController.instance.decrement();
        
        let label = LabelMaker(message: "\(PointsController.instance.points)", messageSize: 60)
        pointsBubble.updateLabel(newLabel: label)
    }
    
    func addFunctionalityBubbles() {
        
        let functionalityTypes = ["replay", "home"];
        
        var x = -(frame.size.width)/2 + frame.size.width/5 + 250;
        
        for type in functionalityTypes {
            let position = CGPoint(x: x, y: -(self.frame.size.height)/2 + 150);
            let button = Bubble(type: "\(type)", scale: 0.65, bubblePosition: position, label: nil)
            
            self.addChild(button);
            ActionManager.instance.rotateBackForth(node: button, denominator: 100);
            
            x += frame.size.width/5;
        }
        
    }
    
    
    
    
    
    
    
    
    private var pointsLabel: SKLabelNode?;
    
    private func getReference() {
        pointsLabel = (self.childNode(withName: "Points Label") as? SKLabelNode?)!;
    }
    
    private func setPoints() {
        if GameManager.instance.getEasyDifficulty() {
            pointsLabel?.text = String(GameManager.instance.getEasyDifficultyScore());
        } else if GameManager.instance.getMediumDifficulty() {
            pointsLabel?.text = String(GameManager.instance.getMediumDifficultyScore());
        } else if GameManager.instance.getHardDifficulty() {
            pointsLabel?.text = String(GameManager.instance.getHardDifficultyScore());
        }
    }

}
