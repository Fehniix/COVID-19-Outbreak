//
//  SKAction.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

extension SKAction {
	public static func pulsateForever(with textures: [SKTexture], timePerFrame sec: TimeInterval) -> SKAction {
		let animForwards = SKAction.animate(with: textures, timePerFrame: sec)
		let animBackwards = animForwards.reversed()
		
		return SKAction.repeatForever(SKAction.sequence([animForwards, animBackwards]))
	}
}
