//
//  DifficultyManager.swift
//  CapGame
//
//  Created by Brandy Austin on 7/20/18.
//  Copyright © 2018 Brandy Austin. All rights reserved.
//

import Foundation

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

    
    func setFactors(difficulty: String) {
        switch difficulty {
            case "easy":
                drinkFactor = 4;
                bonusFactor = 4;

                insectFactor = 9;
                rockFactor = 2;
                
                portalFactor = 4;
                standPlaneFactor = 3;
        
                startAloneFactor = 8;
                lowMiddleEndFactor = 8;
                highMiddleEndFactor = 8;
                lowHighFactor = 5;
                
                return
        
            case "medium":
                drinkFactor = 3;
                bonusFactor = 2;
                
                insectFactor = 4;
                rockFactor = 3;
                
                portalFactor = 4;
                standPlaneFactor = 3;
                
                startAloneFactor = 6;
                lowMiddleEndFactor = 6;
                highMiddleEndFactor = 6;
                lowHighFactor = 6;
                
                return
        
            case "hard":
                
                drinkFactor = 2;
                bonusFactor = 1;
                
                insectFactor = 6;
                rockFactor = 4;
                
                portalFactor = 4;
                standPlaneFactor = 3;
                
                startAloneFactor = 5;
                lowMiddleEndFactor = 5;
                highMiddleEndFactor = 5;
                lowHighFactor = 6;
   
                return
        
            default:
                return
        }
    }
}
