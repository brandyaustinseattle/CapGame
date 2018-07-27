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
    }
    
    func initialize() {
        setSceneOption();
        
        addLoadingIcon();
        preludeScene();
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
    
    func preludeScene() {
        delay(time: 3) {
            let newScene = Prelude(fileNamed: "Prelude")!;
            newScene.scaleMode = .aspectFill;

            let crossFade = SKTransition.crossFade(withDuration: 0.0015);
    
            self.view?.presentScene(newScene, transition: crossFade);
        }
    }
    
    func addLoadingIcon() {
        let loading = loadingPrep();
        
        self.run(SKAction.repeatForever(loading), withKey: "loadingKey");
    }
    
    func loadingPrep() -> SKAction {
        var loadingSequence = [SKTexture]();
        
        for i in 1...6 {
            let imageName = "Loading\(i)";
            loadingSequence.append(SKTexture(imageNamed: imageName));
        }
        
        let loading = SKAction.animate(with: loadingSequence, timePerFrame: TimeInterval(0.28), resize: true, restore: true);
        
        return loading;
    }
    
}
