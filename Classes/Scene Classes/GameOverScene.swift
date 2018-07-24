//
//  GameOverScene.swift
//  CapGame
//
//  Created by Brandy Austin on 7/16/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit


class GameOverScene: StaticScene {

    override var text : String {
        get { return "game over" }
        set { }
    }
    
    var timer = Timer();
    let pointsBubble = Points.instance.getPointsBubble();
    
    override func setUp() {
        self.addChild(pointsBubble);
        
        super.initialize(playerImage: "standing1");
        
        delay(time: 3) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.countDownPoints), userInfo: nil, repeats: true);
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.managePlayerJumps();
    }
    
    @objc func countDownPoints() {
        
        if Points.instance.value == 0 {
            timer.invalidate();
            return
        }
        
        Points.instance.decrement();
        
        let label = LabelMaker(message: "\(Points.instance.value)", messageSize: 60)
        pointsBubble.updateLabel(newLabel: label)
    }

}
