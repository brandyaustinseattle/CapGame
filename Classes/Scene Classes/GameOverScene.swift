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
        
        setPoints();
        
        addFunctionalityBubbles();
        addScoreBubbles();

        self.addChild(pointsBubble);
        
        super.initialize(playerImage: "standing1");
        
        delay(time: 3) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.countDownPoints), userInfo: nil, repeats: true);
        }
    }
    
    private var highScore: SKLabelNode?;
    
    
    private func setPoints() {
        if GameManager.instance.getEasyDifficulty() {
            highScore?.text = String(GameManager.instance.getEasyDifficultyScore());
        } else if GameManager.instance.getMediumDifficulty() {
            highScore?.text = String(GameManager.instance.getMediumDifficultyScore());
        } else if GameManager.instance.getHardDifficulty() {
            highScore?.text = String(GameManager.instance.getHardDifficultyScore());
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!;
        let positionInScene = touch.location(in: self);
        let touchedNode = self.atPoint(positionInScene);
        
        if touchedNode.name == "home" {
            transitionScenes(oldScene: self, newScene: IntroScene(fileNamed: "IntroScene")!);
            
        } else if touchedNode.name == "play" {
            transitionScenes(oldScene: self, newScene: GameScene(fileNamed: "GameScene")!);
            PointsController.instance.points = 0;
            
            GameManager.instance.gameStartedFromMainMenu = false;
            GameManager.instance.gameRestartedPlayerDied = true;
            
        } else {
            super.managePlayerJumpsOnTouch();
        }
    }
    
    @objc func countDownPoints() {
        
        if PointsController.instance.points == 0 {
            timer.invalidate();
            pointsBubble.removeFromParent();
            return
        }
        
        PointsController.instance.decrement();
        
        let label = LabelMaker(message: "\(PointsController.instance.points)", messageSize: 60)
        pointsBubble.updateLabel(newLabel: label)
    }
    
    func addFunctionalityBubbles() {
        
        let functionalityTypes = ["play", "home"];
        
        var x = -(frame.size.width)/2 + frame.size.width/5 + 250;
        
        for type in functionalityTypes {
            let position = CGPoint(x: x, y: -(self.frame.size.height/2) + 150);
            let button = Bubble(type: "\(type)", scale: 0.65, bubblePosition: position, label: nil)
            
            self.addChild(button);
            ActionManager.instance.rotateBackForth(node: button, denominator: 100);
            
            x += frame.size.width/5;
        }
        
    }
    
    func addScoreBubbles() {
                
        let pointsLabel = LabelMaker.init(message: "\(PointsController.instance.points)", messageSize: 80);
        pointsLabel.position = CGPoint(x: 0, y: -50);
        let pointsPosition = CGPoint(x: 0, y: 275);
        let totalBubble = Bubble(type: "totalScore", scale: 0.75, bubblePosition: pointsPosition, label: pointsLabel);
        self.addChild(totalBubble);
        
        let easy = GameManager.instance.getEasyDifficulty();
        let medium = GameManager.instance.getMediumDifficulty();
        let hard = GameManager.instance.getHardDifficulty();

        if easy {
            let highPosition = CGPoint(x: 0, y: 50);
            let highScore = (GameManager.instance.getEasyDifficultyScore());
            let highLabel = LabelMaker.init(message: "\(highScore)", messageSize: 50);
            highLabel.position = CGPoint(x: 0, y: -25);
            
            let highScoreBubble = Bubble(type: "easyHighScore", scale: 1.25, bubblePosition: highPosition, label: highLabel);
            self.addChild(highScoreBubble);
            
        } else if medium {
            let highPosition = CGPoint(x: 0, y: 50);
            let highScore = (GameManager.instance.getMediumDifficultyScore());
            let highLabel = LabelMaker.init(message: "\(highScore)", messageSize: 50);
            highLabel.position = CGPoint(x: 0, y: -25);
            
            let highScoreBubble = Bubble(type: "mediumHighScore", scale: 1.25, bubblePosition: highPosition, label: highLabel);
            self.addChild(highScoreBubble);
            
        } else if hard {
            let highPosition = CGPoint(x: 0, y: 50);
            let highScore = (GameManager.instance.getHardDifficultyScore());
            let highLabel = LabelMaker.init(message: "\(highScore)", messageSize: 50);
            highLabel.position = CGPoint(x: 0, y: -25);
            
            let highScoreBubble = Bubble(type: "hardHighScore", scale: 1.25, bubblePosition: highPosition, label: highLabel);
            self.addChild(highScoreBubble);

        } else {
            return;
        }
    }

}
