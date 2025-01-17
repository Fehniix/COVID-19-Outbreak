//
//  VirusSceneNode.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 22/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class VirusScene: SKSpriteNode {
	
	//	Global References short alias
	private let globRefs: References 		= References.shared
	
	//	Defines the bounds of the scene.
	private var backgroundNode: SKSpriteNode! 	= nil
	
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(texture: nil, color: ColorPalette.lightest, size: globRefs.extendedFrame.size)
		
		self.name 			= "VirusSceneNode"
		self.anchorPoint 	= CGPoint(0, 0)
		
		self.backgroundNode 			= SKSpriteNode(texture: nil, color: UIColor.clear, size: globRefs.deviceFrame.size)
		self.backgroundNode.position	= CGPoint(self.frame.midX, 0)	// Since the BGNode's anchorPoint is (0,0) and so its parent, the y coordinate doesn't have to change, otherwise the background parent constraining the objects within the scene would be y-translated.
		self.backgroundNode.anchorPoint = CGPoint(0.5, 0)
		self.backgroundNode.name 		= "VirusSceneNode_bg"
		
		addChild(self.backgroundNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
