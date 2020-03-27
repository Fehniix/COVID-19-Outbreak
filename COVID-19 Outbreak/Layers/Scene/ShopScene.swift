//
//  ShopScene.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 27/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class ShopScene: SKNode {
	
	//	Global References short alias
	private let globRefs: GlobalReferences 		= GlobalReferences.shared
	
	//	Hierarchically last, defines Scene's bounds.
	private var backgroundNode: SKShapeNode! 	= nil
	
	override init() {
		super.init()
		
		self.backgroundNode 			= SKShapeNode(rect: globRefs.extendedFrame)
		self.backgroundNode.fillColor 	= ColorPalette.light
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
