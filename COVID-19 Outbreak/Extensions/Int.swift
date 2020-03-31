//
//  Int.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 30/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

extension Int {
	static prefix func --(rhs: inout Int) -> Int {
		rhs -= 1
		return rhs
	}
	
	static prefix func ++(rhs: inout Int) -> Int {
		rhs += 1
		return rhs
	}
}
