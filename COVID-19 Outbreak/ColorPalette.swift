//
//  ColorPalette.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//
import UIKit

struct ColorPalette {
	private static let _lightest 	= 0xfff8cb
	private static let _light 		= 0xfff199
	private static let _normal 		= 0xffb37b
	private static let _dark 		= 0xb1717a
	private static let _darkest 	= 0x49304d
	
	public static let lightest: UIColor = UIColor(withHexCode: _lightest, alpha: 1.0)
	public static let light: 	UIColor = UIColor(withHexCode: _light, alpha: 1.0)
	public static let normal: 	UIColor = UIColor(withHexCode: _normal, alpha: 1.0)
	public static let dark: 	UIColor = UIColor(withHexCode: _dark, alpha: 1.0)
	public static let darkest: 	UIColor = UIColor(withHexCode: _darkest, alpha: 1.0)
}
