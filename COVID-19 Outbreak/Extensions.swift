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
