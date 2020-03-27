//
//  VirusNode.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 23/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class VirusNode: SKSpriteNode {
	
	///	Designated initialiser
	override init(texture: SKTexture?, color: UIColor, size: CGSize) {
		super.init(
			texture: texture,
			color: color,
			size: size)
	}
	
	convenience init(gameSceneFrame: CGRect) {
		
		//	Original image's aspect ratio.
		let aspectRatio: CGFloat = 182 / 202
		
		self.init(
			texture: SKTexture(imageNamed: "Coronavirus"),
			color: UIColor.red,
			size: CGSize(
				width: gameSceneFrame.width / 2 * aspectRatio,
				height: gameSceneFrame.width / 2)
		)
		
		self.position = gameSceneFrame.midPoint()
		self.isUserInteractionEnabled = true
		
		self.startAnimation()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func startAnimation() {
		//	Retrieve atlas
		let atlas: SKTextureAtlas = SKTextureAtlas(named: "Virus")
		let textures: [SKTexture] = atlas.textures

		self.run(SKAction.pulsateForever(with: textures, timePerFrame: 1.0 / 60.0), withKey: "virusPulsating")
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		print("tapped")
	}
	
	
	
}
