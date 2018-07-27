//
//  Points.swift
//  CapGame
//
//  Created by Brandy Austin on 7/13/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import SpriteKit

class PointsController {

    static let instance = PointsController();

    private init() {}
    
    var points = Int();
    
    
    func initializeVariables() {
        if GameManager.instance.gameStartedFromMainMenu {

            GameManager.instance.gameStartedFromMainMenu = false;

            points = 0;

        } else if GameManager.instance.gameRestartedPlayerDied {

            GameManager.instance.gameRestartedPlayerDied = false;

        }
    }
    
    
    func increment(consumableName: String) {
        if consumableName == "Cake" {
            points += 1;
        } else if consumableName == "Bonus" {
            points += 5;
        }
    }
    
    func decrement() {
        if points == 0 {
            return
        }
        points -= 1;
    }
    
    func getPointsBubble() -> Bubble {
        
        let position = CGPoint(x: 590, y: 320);
        let label = LabelMaker(message: "\(PointsController.instance.points)", messageSize: 60);
    
        let pointsBubble = Bubble(type: "roundcloud", scale: 0.75, bubblePosition: position, label: label);
        
        return pointsBubble;
    }
    
}
