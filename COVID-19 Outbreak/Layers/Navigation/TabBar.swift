//
//  TabBar.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class TabBarNode: SKSpriteNode {
	private var activeItemNode: SKSpriteNode!
	
	init() {
		super.init(
			texture: SKTexture(imageNamed: "TabBar"),
			color: UIColor.clear,
			size: CGSize(GlobalReferences.shared.deviceFrame.width, GlobalReferences.shared.deviceFrame.height / 9.6))
		
		self.activeItemNode = SKSpriteNode(texture: SKTexture(imageNamed: "TabBar_active"))
		self.activeItemNode.anchorPoint = CGPoint(0.5, 0)
		self.activeItemNode.zPosition = self.zPosition + 1
		
		self.addChild(self.activeItemNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class SKTabBarController {
	/*
		- Shows a user customised TabBar as a top-most layer.
		- Stores SKTabView's
		- Default swipe/pan animations are overridable
	*/
	
	//	Composited node containing the ScrollableView (with the SKTabView's) and the SKTabBar
	//	Note: the composited node has to have a (0.5, 0) anchorPoint! We suppose the parent SKView has the default frame's size.
	private var node: SKSpriteNode
	
	//	View array
	private var views: [SKTabView] = []
	
	//	Index of the current view
	private var currentViewIndex: Int = 0
	
	///	Size of the SKTabView's that will be added to the controller. Defaults to the bounds of the current device.
	public var tabViewSize: CGRect!
	
	public init() {
		self.node 			= SKSpriteNode()
		self.tabViewSize 	= UIScreen.main.bounds
	}
	
	convenience init(with initialIndex: Int) {
		self.init()
		
		self.currentViewIndex = initialIndex
	}
	
	convenience init(given tabViewSize: CGRect, with initialIndex: Int) {
		self.init()
		
		self.currentViewIndex 	= initialIndex
		self.tabViewSize 		= tabViewSize
	}
	
	public func addView(view: SKTabView) {
		self.views.append(view)
	}
	
	public func present() {
		//	Compose SKTabView's into an horizontal SKScrollableView
		//	Compose SKTabBar
		//	Compose the two together and append them to the view
		
		//	Compose views.
		self.composeViews()
		
		//	Compose tab bar.
		
	}
	
	private func composeViews() {
		self.node.size = CGSize(self.tabViewSize.width * self.views.count, self.tabViewSize.height)
		
		for (index, view) in self.views.enumerated() {
			let viewNode = view.node()!
			viewNode.anchorPoint 	= CGPoint(0, 0)
			viewNode.position 		= CGPoint(self.tabViewSize.width * index, 0)
			
			self.node.addChild(view.node()!)
		}
	}
}

class SKTabView {
	private var child: 		SKNode?
	
	private var texture:	SKTexture?
	private var fillColor:	SKColor?
	
	/// Initialise the SKTabView with a texture and fillColor. The size of the SKTabView is fixed, previously set in SKTabBarController.
	init(texture: SKTexture?, fillColor: SKColor) {
		self.texture = texture
		self.fillColor = fillColor
	}
	
	///	Initialise the SKTabView with a fillColor, defaulting its size to the frame of the device.
	init(fillColor: SKColor) {
		self.fillColor = fillColor
	}
	
	/// Initialises the SKTabView with a previously built `SKNode` layer.
	/// - Parameter compositedView: Layer as instance of `SKNode`.
	init(with compositedView: SKNode) {
		self.child = compositedView
	}
	
	fileprivate func node() -> SKSpriteNode? {
		return (child ?? nil) as? SKSpriteNode
	}
}

