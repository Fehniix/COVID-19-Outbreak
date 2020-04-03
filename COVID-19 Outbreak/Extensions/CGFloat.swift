//
//  CGFloat.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

infix operator ~/ : MultiplicationPrecedence

extension CGFloat {
	func reciprocal() -> CGFloat {
		return 1 / self
	}

	static func ~/ (rhs: CGFloat, lhs: Int) -> CGFloat {
		return lhs != 0 ? (rhs / CGFloat(lhs)) : CGFloat.infinity
	}
	
	static prefix func -- (rhs: inout CGFloat) -> CGFloat {
		rhs -= 1
		return rhs
	}
	
	static prefix func ++ (rhs: inout CGFloat) -> CGFloat {
		rhs += 1
		return rhs
	}
	
	static func * (lhs: CGFloat, rhs: Int) -> CGFloat {
		return lhs * CGFloat(rhs)
	}
}
