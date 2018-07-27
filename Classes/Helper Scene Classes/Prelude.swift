//
//  Prelude.swift
//  CapGame
//
//  Created by Brandy Austin on 7/19/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class Prelude: SKScene {
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    func initialize() {
        BackGroundManager.instance.createBG(scene: self);
        BackGroundManager.instance.createBGAddOn(scene: self);
        rotateLogo();
        
        introScene();
    }
    
    private func introScene() {
        delay(time: 2) {
            let newScene = IntroScene(fileNamed: "IntroScene")!;
            transitionScenes(oldScene: self, newScene: newScene)
        }
    }
    
    func rotateLogo() {
        var logo = self.childNode(withName: "logoWhite");
        logo = logo as! SKSpriteNode;
        ActionManager.instance.rotateBackForth(node: logo!, denominator: 50);
    }
    
}
