//
//  EnemyController.swift
//  Session1
//
//  Created by Admin on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class EnemyController : Controller{
    let SPEED : Double = 1000
    override func setup(parent : SKNode) -> Void {
        addFlyAction(parent)
    }
    
    func addFlyAction(parent : SKNode) -> Void {
        let distanceToFloor =  Double (parent.frame.height - self.view.frame.height)
        
        let timeToReachRoof = distanceToFloor / SPEED
        
        self.view.runAction(
            SKAction.sequence([
                SKAction.moveToY(parent.frame.height, duration: timeToReachRoof),
                SKAction.removeFromParent()
                ])
        )
    }
}

