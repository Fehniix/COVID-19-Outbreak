//
//  DirectorScene.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 27/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

/**
The `MasterScene` contains the three scenes of the game: shop, research and virus scene.
The three scenes are all preloaded into memory, laying one along another, with one shown and the others hidden form the users.
This scene additionally handles UIPanGesture and UISwipeGesture, to switch between scenes and update the TabBarActiveItem.
*/
class MasterScene: SKScene {
	
	//	Scenes to switch between
	private let shopScene: 		SKNode! = nil
	private let virusScene: 	SKNode! = nil
	private let researchScene: 	SKNode! = nil
	
	//	Composited master scene, containing all scenes
	private let masterScene:	SKNode! = nil
	
	override func didMove(to view: SKView) {
		
	}
	
	private func composeMasterScene() {
		
	}
	
}
