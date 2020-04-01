//
//  GlobalReferences.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 27/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class References {
	
	//	Singleton pattern to share global references, such as device frame etc.
	public static let shared: References = References()
	
	//	References
	public var deviceFrame: CGRect! {
		didSet {
			self.extendedFrame = CGRect(
				origin: deviceFrame.origin,
				size: CGSize(
					width: deviceFrame.width + deviceFrame.width / 2,
					height: deviceFrame.height)
			)
		}
	}
	
	/// iPhone frame += 50% width (25% per side), to allow for animation margin.
	public var extendedFrame: 		CGRect! 	= nil
	/// Index of the currently displayed Tab
	public var currentPageIndex: 	Int! 		= 1
	///	Number of Tabs to show
	public var pages:				Int!		= 3
	
	private init() {}
}
