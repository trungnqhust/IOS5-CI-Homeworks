//
//  Controller.swift
//  Session1
//
//  Created by Admin on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class Controller {
    internal let view : View
    
    func setup(parent : SKNode) -> Void {
        
    }
    
    init(view: View){
        self.view = view
    }
    
    // move to a specific position
    func moveTo(position : CGPoint) -> Void {
        self.view.position = position
    }
    
    //move by a vector
    func moveBy(vector : CGPoint) -> Void {
        let newPosition = self.view.position.add(vector)
        self.view.position = newPosition
    }

}
