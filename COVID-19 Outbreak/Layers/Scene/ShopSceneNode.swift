//
//  ShopScene.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 27/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class ShopSceneNode: SKSpriteNode {
	
	//	Global References short alias
	private let globRefs: GlobalReferences 		= GlobalReferences.shared
	
	//	Hierarchically last, defines Scene's bounds.
	private var backgroundNode: SKSpriteNode! 	= nil
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: nil, color: UIColor.clear, size: globRefs.extendedFrame.size)
		
		self.name 			= "ShopSceneNode"
		self.anchorPoint 	= CGPoint(0, 0)
		
		self.backgroundNode 			= SKSpriteNode(texture: nil, color: ColorPalette.light, size: self.size)
		self.backgroundNode.anchorPoint = CGPoint(0, 0)
		self.backgroundNode.name 		= "ShopScene_background"
		
		let labelTest = SKLabelNode(text: "Shop Test")
		labelTest.fontColor = ColorPalette.darkest
		
		addChild(self.backgroundNode)
		addChild(labelTest)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
