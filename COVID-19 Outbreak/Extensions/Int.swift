//
//  Int.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 30/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

extension Int {
	enum Sign: Int {
		case plus
		case minus
		
		@inlinable static func == (lhs: FloatingPointSign, rhs: Sign) -> Bool {
			return lhs.rawValue == rhs.rawValue
		}
		
		@inlinable static func != (lhs: FloatingPointSign, rhs: Sign) -> Bool {
			return lhs.rawValue != rhs.rawValue
		}
	}
	
	var sign: Sign {
		return (self > 0) ? .plus : .minus
	}
	
	static prefix func --(rhs: inout Int) -> Int {
		rhs -= 1
		return rhs
	}
	
	static prefix func ++(rhs: inout Int) -> Int {
		rhs += 1
		return rhs
	}
}
