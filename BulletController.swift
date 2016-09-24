//
//  BulletController.swift
//  Session1
//
//  Created by Admin on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class BulletController : Controller{
    let SPEED : Double = 500
    override func setup(parent : SKNode) -> Void {
        addFlyAction(parent)
        configurePhysics() 
    }
    
    func configurePhysics() -> Void {
        //1
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        //2
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER_BULLET
        view.physicsBody?.collisionBitMask = 0
            view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY
    }
    
    
    func addFlyAction(parent : SKNode) -> Void {
        let distanceToRoof =  Double (parent.frame.height - self.view.position.y)
        
        let timeToReachRoof = distanceToRoof / SPEED
        
        self.view.runAction(
            SKAction.sequence([
                    SKAction.moveToY(parent.frame.height, duration: timeToReachRoof),
                    SKAction.removeFromParent()
                ])
        )
    }
}