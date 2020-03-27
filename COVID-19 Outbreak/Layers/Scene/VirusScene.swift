//
//  GameScene.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 22/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class VirusScene: SKScene {
    
	override func didMove(to view: SKView) {
		let virusNode = VirusNode(gameSceneFrame: frame)
		
		addChild(virusNode)
	}
	
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
	
}
