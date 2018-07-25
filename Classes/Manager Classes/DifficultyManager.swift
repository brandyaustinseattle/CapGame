//
//  DifficultyManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/20/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//


import Foundation
import SpriteKit

//  store as NSObject...data stored on phone
class DifficultyManager {
    
    static let instance = DifficultyManager();
    
    private init() {}
    
    private(set) var drinkFactor = Int();
    private(set) var bonusFactor = Int();

    private(set) var insectFactor = Int();
    private(set) var rockFactor = Int();

    private(set) var portalFactor = Int();
    private(set) var standPlaneFactor = Int();

    private(set) var startAloneFactor = Int();
    private(set) var lowMiddleEndFactor = Int();
    private(set) var highMiddleEndFactor = Int();
    private(set) var lowHighFactor = Int();
    
    private(set) var speed = CGFloat();

    
    func setFactors(difficulty: String) {
        switch difficulty {
            case "easy":
                drinkFactor = 5;
                bonusFactor = 5;

                insectFactor = 9;
                rockFactor = 2;

                portalFactor = 5;
                standPlaneFactor = 4;

                startAloneFactor = 8;
                lowMiddleEndFactor = 8;
                highMiddleEndFactor = 8;
                lowHighFactor = 5;
                speed = CGFloat(175);

                return
        
            case "medium":
                drinkFactor = 4;
                bonusFactor = 3;
                
                insectFactor = 4;
                rockFactor = 3;
                
                portalFactor = 4;
                standPlaneFactor = 3;
                
                startAloneFactor = 6;
                lowMiddleEndFactor = 6;
                highMiddleEndFactor = 6;
                lowHighFactor = 6;
                speed = CGFloat(175);
                
                return
        
            case "hard":
                
                drinkFactor = 3;
                bonusFactor = 2;
                
                insectFactor = 6;
                rockFactor = 4;
                
                portalFactor = 4;
                standPlaneFactor = 3;
                
                startAloneFactor = 5;
                lowMiddleEndFactor = 5;
                highMiddleEndFactor = 5;
                lowHighFactor = 6;
                speed = CGFloat(175);
   
                return
            
            case "demo":
            
                drinkFactor = 2;
                bonusFactor = 4;
            
                insectFactor = 1;
                rockFactor = 1;
            
                portalFactor = 2;
                standPlaneFactor = 3;
            
                startAloneFactor = 9;
                lowMiddleEndFactor = 8;
                highMiddleEndFactor = 8;
                lowHighFactor = 6;
                speed = CGFloat(80);
            
            return
        
            default:
                return
        }
    }
}
