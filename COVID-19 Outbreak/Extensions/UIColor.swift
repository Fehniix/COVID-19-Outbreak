//
//  UIColor.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

extension UIColor {
	convenience init(withHexCode hex: Int, alpha: CGFloat) {
		let red 	= CGFloat((hex >> 16) & 0xFF) / 255
		let green 	= CGFloat((hex >> 8) & 0xFF) / 255
		let blue 	= CGFloat(hex & 0xFF) / 255
		
		self.init(
			red: 	red,
			green: 	green,
			blue: 	blue,
			alpha: 	alpha
		)
	}
}
