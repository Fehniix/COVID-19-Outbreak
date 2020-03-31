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

# Coordinate Space
A little note on coordinates.

- At position {0, 0} is the middle scene.
*/
class MasterScene: SKScene {
	//	Tab Bar
	private var tabBarNode:			SKSpriteNode! = nil
	
	//	Scenes to switch between
	private var shopSceneNode: 		SKSpriteNode! = nil
	private var virusSceneNode: 	SKSpriteNode! = nil
	private var researchSceneNode: 	SKSpriteNode! = nil
	
	//	Composited master scene, containing all scenes
	private var masterSceneNode:	SKSpriteNode! = nil
	
	//	TabBar controller properties
	private var currentPageIndex: 	Int 		= 1
	private var pages: 				Int			= 3
	private var pageXOffset: 		CGFloat! 	= nil
	
	//	Swipe gesture properties
	private let velocityThreshold: 	CGFloat 	= 16
	private var swiped:				Int			= 0
	private var initialXPosition:	CGFloat 	= CGFloat()
	private var swipeThreshold: 	CGFloat		= 0
	
	override func didMove(to view: SKView) {
		//	The scene's width is three times the extended frame
		self.size = CGSize(width: GlobalReferences.shared.extendedFrame.width * 3, height: view.frame.size.height)
		
		//	Creating the masterSceneNode to contain all the other scenes.
		self.masterSceneNode 				= SKSpriteNode(texture: nil, color: UIColor.clear, size: self.size)
		self.masterSceneNode.anchorPoint 	= CGPoint(0, 0)
		
		//	Creating the tab bar
		self.createTabBar()
		
		//	Creating the three tab sceneNodes.
		self.createTabScenes()
		
		self.masterSceneNode.addChild(self.shopSceneNode)
		self.masterSceneNode.addChild(self.virusSceneNode)
		self.masterSceneNode.addChild(self.researchSceneNode)
		
		self.addChild(self.masterSceneNode)
		self.addChild(self.tabBarNode)
		
		self.pageXOffset 	= GlobalReferences.shared.extendedFrame.width
		self.swipeThreshold = GlobalReferences.shared.deviceFrame.width / 2
	}
	
	private func createTabBar() {
		self.tabBarNode 			= TabBarNode()
		self.tabBarNode.zPosition 	= 10
		self.tabBarNode.anchorPoint = CGPoint(0.5, 0)
		self.tabBarNode.position	= CGPoint(GlobalReferences.shared.extendedFrame.maxX * 3 / 2, 0)	// "Go to the end of the last scene (*3), and then cut to the middle point (/2)"
	}
	
	private func createTabScenes() {
		self.shopSceneNode 				= ShopScene()
		self.shopSceneNode.position 	= CGPoint(0, 0)
		
		self.virusSceneNode 			= VirusScene()
		self.virusSceneNode.position 	= CGPoint(GlobalReferences.shared.extendedFrame.width, 0)		// Translate the x-coord. to position aside the ShopScene
		
		self.researchSceneNode 			= ResearchScene()
		self.researchSceneNode.position = CGPoint(GlobalReferences.shared.extendedFrame.width * 2, 0)
	}
	
	private func animatedSwipe(to index: Int) {
		//	Reminder: the MasterScene's anchorPoint is (0, 0)!
		//	Moving positively means moving to the left, moving negatively to the right.
		if Debug.debugActive { print("[Swipe] Move to page index: \(index), mapped: \(self.mapIndex(index: index))") }
		let swipeAction = SKAction.moveTo(x: self.pageXOffset * self.mapIndex(index: index), duration: 0.3)
		swipeAction.timingMode = .easeOut
		
		self.masterSceneNode.run(swipeAction)
	}
	
	private func didSwipe(deltaTouch: CGFloat) {
		if deltaTouch < 0 {
			//	Swipe left, next page
			self.swiped = 1
		} else if deltaTouch > 0 {
			//	Swipe right, previous page
			self.swiped = -1
		}
	}
	
	private func canSwipe(deltaTouch: CGFloat) -> Bool {
		if self.currentPageIndex == 0 && deltaTouch > 0 {
			return false
		}
		if self.currentPageIndex == self.pages - 1 && deltaTouch < 0 {
			return false
		}
		return true
	}
	
	private func mapIndex(index: Int) -> Int {
		return (index - (self.pages - 1) / 2) * -1
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.initialXPosition = self.masterSceneNode.position.x
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touch 			= touches.first!.location(in: masterSceneNode)
		let previousTouch 	= touches.first!.previousLocation(in: masterSceneNode)
		
		let deltaTouch 		= touch.x - previousTouch.x
		
		if self.canSwipe(deltaTouch: deltaTouch) {
			if abs(deltaTouch) > self.velocityThreshold {
				self.didSwipe(deltaTouch: deltaTouch)
			} else if abs(self.initialXPosition - self.masterSceneNode.position.x) > self.swipeThreshold {
				self.didSwipe(deltaTouch: deltaTouch)
			}
		}
		
		self.masterSceneNode.position.x += deltaTouch
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		//	Return to original position, swipe was canceled
		if self.swiped == 0 || abs(self.initialXPosition - self.masterSceneNode.position.x) < self.swipeThreshold {
			self.swiped = 0
			
			let moveToOriginalPosition 			= SKAction.moveTo(
				x: self.pageXOffset * self.mapIndex(index: self.currentPageIndex),
				duration: 0.3
			)
			moveToOriginalPosition.timingMode 	= .easeOut
		
			self.masterSceneNode.run(moveToOriginalPosition)
		} else {
			if swiped == 1 {
				self.animatedSwipe(to: ++self.currentPageIndex)
			} else if swiped == -1 {
				self.animatedSwipe(to: --self.currentPageIndex)
			}
			self.swiped = 0
		}
	}
}
