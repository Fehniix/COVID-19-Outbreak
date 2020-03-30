//
//  TabBar.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class TabBarNode: SKSpriteNode {
	private var activeItemNode: SKSpriteNode!
	
	init() {
		super.init(
			texture: SKTexture(imageNamed: "TabBar"),
			color: UIColor.clear,
			size: CGSize(GlobalReferences.shared.deviceFrame.width, GlobalReferences.shared.deviceFrame.height / 9.6))
		
		self.activeItemNode = SKSpriteNode(texture: SKTexture(imageNamed: "TabBar_active"))
		self.activeItemNode.anchorPoint = CGPoint(0.5, 0)
		self.activeItemNode.zPosition = self.zPosition + 1
		
		self.addChild(self.activeItemNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
