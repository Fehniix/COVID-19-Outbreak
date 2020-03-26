//
//  Extensions.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 23/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

extension CGRect {
	func midScreen() -> CGPoint {
		return CGPoint(x: midX, y: midY)
	}
}

extension CGFloat {
	func reciprocal() -> CGFloat {
		return 1 / self
	}
}

extension SKAction {
	public static func pulsateForever(with textures: [SKTexture], timePerFrame sec: TimeInterval) -> SKAction {
		let animForwards = SKAction.animate(with: textures, timePerFrame: sec)
		let animBackwards = animForwards.reversed()
		
		return SKAction.repeatForever(SKAction.sequence([animForwards, animBackwards]))
	}
}

extension SKTextureAtlas {
	/**
	Contains a sorted, mapped array containing the SKTextureAtlas' SKTexture's.
		
	This computed property comes with an SKTextureAtlas extension, declared in ~/Extensions/SKTextureAtlas, where `~` is the project's root directory.
	It calls `.sorted()` on its `textureNames` and `.map()` to the sorted `string` array, mapping it to the corresponding `textureNamed(_)`.
		
	- Important: **Cache the textures**! This computed property sorts and maps the SKTextureAtlas' SKTextures!
	*/
	public var textures: [SKTexture] {
		return textureNames.sorted().map { textureNamed($0) };
	}
}
