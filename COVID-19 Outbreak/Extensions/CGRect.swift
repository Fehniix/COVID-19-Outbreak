//
//  CGRect.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

extension CGRect {
	func midScreen() -> CGPoint {
		return CGPoint(x: midX, y: midY)
	}
}
