//
//  Loading.swift
//  CapGame
//
//  Created by Brandy Austin on 7/20/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

var option = String();
var lastOption = String();

class Loading: SKScene {
    
    override func didMove(to view: SKView) {
        initialize();
        
        self.introScene();
    }
    
    func initialize() {
        setSceneOption();
        
        self.introScene();
    }
    
    public func setSceneOption() {
        
        lastOption = option;
        let sceneOptions = ["A", "B", "C"];
        let maxIndex = sceneOptions.count - 1;

        while option == lastOption {
            let sceneIndex = Int.random(min: 0, max: maxIndex);
            option = sceneOptions[sceneIndex];
        }
    }
    
    func introScene() {
        let newScene = IntroScene(fileNamed: "IntroScene")!;
        newScene.scaleMode = .aspectFill;

        let crossFade = SKTransition.crossFade(withDuration: 0.015);
    
        self.view?.presentScene(newScene, transition: crossFade);
    }
}
