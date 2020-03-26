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
		let red 	= ((hex >> 16) & 0xFF) / 255
		let green 	= ((hex >> 8) & 0xFF) / 255
		let blue 	= (hex & 0xFF) / 255
		
		self.init(
			red: 	CGFloat(red),
			green: 	CGFloat(green),
			blue: 	CGFloat(blue),
			alpha: 	alpha
		)
	}
}
