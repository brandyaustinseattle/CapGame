//
//  GameOverScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/16/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class GameOverScene: StaticScene {

    var loadingScene = Loading();
    
    var timer = Timer();
    let pointsBubble = PointsController.instance.getPointsBubble();
    private var highScore: SKLabelNode?;
        
    override var text : String {
        get { return "game over" }
        set { }
    }
    
    override func setUp() {
        
        setPoints();
        
        addFunctionalityBubbles();
        addScoreBoard();

        self.addChild(pointsBubble);
        
        super.initialize(playerImage: "standing1");
        
        delay(time: 3) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.countDownPoints), userInfo: nil, repeats: true);
        }
    }
    
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
            loadingScene.setSceneOption();
            
//            transitionScenes(oldScene: self, newScene: IntroScene(fileNamed: "IntroScene")!);
            
        } else if touchedNode.name == "play" {
            loadingScene.setSceneOption();
            
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
    
    func addScoreBoard() {

        let easy = GameManager.instance.getEasyDifficulty();
        let medium = GameManager.instance.getMediumDifficulty();
        let hard = GameManager.instance.getHardDifficulty();

        var message = String();

        if easy {
            let highScore = (GameManager.instance.getEasyDifficultyScore());
            message = "High Score for Easy: \(highScore)";
        } else if medium {
            let highScore = (GameManager.instance.getMediumDifficultyScore());
            message = "High Score for Medium: \(highScore)";
        } else if hard {
            let highScore = (GameManager.instance.getHardDifficultyScore());
            message = "High Score for Hard: \(highScore)";
        } else {
            return;
        }
        
        let scoreBoard = SKSpriteNode(imageNamed: "scoreBoard");
        scoreBoard.zPosition = 3;
        scoreBoard.setScale(0.75);
        self.addChild(scoreBoard);
        
        let pointsLabel = LabelMaker.init(message: "Score: \(PointsController.instance.points)", messageSize: 50);
        let pointsPosition = CGPoint(x: scoreBoard.position.x, y: scoreBoard.position.y + 50);
        pointsLabel.position = pointsPosition;
        
        self.addChild(pointsLabel);
        
        let highLabel = LabelMaker.init(message: message, messageSize: 50);
        let highPosition = CGPoint(x: scoreBoard.position.x, y: scoreBoard.position.y - 50);
        highLabel.position = highPosition;

        self.addChild(highLabel);
    }
    
}
