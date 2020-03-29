//
//  MasterScene.swift
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

# Structure
- The `MasterScene` is an `SKScene`, presented by the `GameViewController`.
- Each subscene is of type `SKSpriteNode`: that is because many of the necessary methods/properties useful to allow the user to swipe through the tabs (a.k.a. subscenes) are implemented in `SKSpriteNode` and it would be wasteful to re-implement them.

The subscenes are contained in the `masterSceneNode` of size identical to its parent scene. This is the node that will be animated and that will receive and handle user input to swipe/drag.
*/
class MasterScene: SKScene {
	
	//	Scenes to switch between
	private var shopSceneNode: 		SKSpriteNode! = nil
	private var virusSceneNode: 	SKSpriteNode! = nil
	private var researchSceneNode: 	SKSpriteNode! = nil
	
	//	Composited master scene, containing all scenes
	private var masterSceneNode:	SKSpriteNode! = nil
	
	override func didMove(to view: SKView) {
		//	The scene's width is three times the extended frame
		self.size = CGSize(width: GlobalReferences.shared.extendedFrame.width * 3, height: view.frame.size.height)
		
		//	Creating the masterSceneNode to contain all the other scenes.
		self.masterSceneNode 				= SKSpriteNode(texture: nil, color: UIColor.clear, size: self.size)
		self.masterSceneNode.anchorPoint 	= CGPoint(0, 0)
		
		self.shopSceneNode 	= ShopSceneNode()
		
		self.virusSceneNode = VirusSceneNode()
		self.virusSceneNode.position = CGPoint(GlobalReferences.shared.extendedFrame.width, 0)	// Translate the x-coord. to position aside the ShopScene
		
		self.masterSceneNode.addChild(self.shopSceneNode)
		self.masterSceneNode.addChild(self.virusSceneNode)
		self.addChild(self.masterSceneNode)
	}
	
	
}
