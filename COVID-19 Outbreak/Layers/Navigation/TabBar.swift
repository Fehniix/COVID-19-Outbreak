//
//  TabBar.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 26/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import SpriteKit

class TabBar: SKSpriteNode {
	private var shopItemNode:				TabBarItem!
	private var virusItemNode:				TabBarItem!
	private var researchItemNode: 			TabBarItem!
	
	private var mappedNodes:				Dictionary<Int, TabBarItem> = Dictionary<Int, TabBarItem>()
	
	//	Active item node
	private var activeItemNode: 			SKSpriteNode!
	private var activeItemNodeInitialX:		CGFloat?
	
	private var itemsDistance:				CGFloat!
	
	//	Style properties
	private var padding:					CGFloat
	private var spacing: 					CGFloat = 0

	/// Index of the currently displayed Tab
	static public var currentPageIndex: 	Int = 1 {
		willSet {
			previousActiveItemIndex = currentPageMappedIndex
		}
	}
	///	Mapped index of currently displayed Tab
	static public var currentPageMappedIndex: Int {
		get {
			return TabBar.mapIndex(index: TabBar.currentPageIndex)
		}
	}
	
	static private var previousActiveItemIndex:	Int = 0
	///	Number of Tabs to show
	static public var pages:				Int!		= 3
	
	init(barPadding padding: CGFloat) {
		let itemNodeSide: 	CGFloat 	= References.shared.deviceFrame.height ~/ 12
		let itemsWidth: 	CGFloat 	= itemNodeSide * TabBar.pages * 182 / 202
		
		self.padding = padding
		
		super.init(
			texture: SKTexture(imageNamed: "TabBar"),
			color: UIColor.clear,
			size: CGSize(References.shared.deviceFrame.width, References.shared.deviceFrame.height / 9.6))
		
		self.anchorPoint = CGPoint(0, 0)
		self.spacing = (self.frame.width - itemsWidth - (self.padding * 2)) ~/ TabBar.pages
		
		self.shopItemNode = TabBarItem(textureName: "test")
		self.shopItemNode.name 			= "shopItem"
		self.shopItemNode.position 		= CGPoint(-self.frame.width / 2 + padding, self.frame.midY)
		self.shopItemNode.zPosition 	= self.zPosition + 2
		
		self.virusItemNode = TabBarItem(textureName: "test")
		self.virusItemNode.name			= "virusItem"
		self.virusItemNode.position 	= CGPoint(0, self.frame.midY)
		self.virusItemNode.zPosition 	= self.zPosition + 2
		self.virusItemNode.color		= SKColor.white
		self.virusItemNode.setScale(1.3)
		
		self.researchItemNode = TabBarItem(textureName: "test")
		self.researchItemNode.name 			= "researchItem"
		self.researchItemNode.position 		= CGPoint(self.frame.width / 2 - padding, self.frame.midY)
		self.researchItemNode.zPosition 	= self.zPosition + 2
		
		self.activeItemNode = SKSpriteNode(texture: SKTexture(imageNamed: "TabBar_active"))
		self.activeItemNode.anchorPoint = CGPoint(0.5, 0)
		self.activeItemNode.zPosition = self.zPosition + 1
		
		self.itemsDistance = self.researchItemNode.position.x
		
		self.addChild(self.shopItemNode)
		self.addChild(self.virusItemNode)
		self.addChild(self.researchItemNode)
		self.addChild(self.activeItemNode)
		
		self.mappedNodes.updateValue(researchItemNode, forKey: 1)
		self.mappedNodes.updateValue(virusItemNode, forKey: 0)
		self.mappedNodes.updateValue(shopItemNode, forKey: -1)
	}
	
	//	+0.5: lower bound, swipe right
	//	-0.5: upper bound, swipe left
	public func updateActiveItem(deltaTouch: CGFloat) {
		//	Movement range between items
		if (deltaTouch == 0) {
			return
		}
		
		if (self.activeItemNodeInitialX == nil) {
			self.activeItemNodeInitialX = self.activeItemNode.position.x
		}
		
		let page_itemProportion = self.itemsDistance / References.shared.deviceFrame.width
		
		self.activeItemNode.position.x += deltaTouch * page_itemProportion
		
		//	Displacement from center (x = 0) of the activeItemNode.
		//	-1.0 < displacement < 1.0
		var activeItemDisplacement: CGFloat = self.activeItemNode.position.x / self.itemsDistance
		if TabBar.currentPageMappedIndex != 0 {
			activeItemDisplacement = CGFloat(TabBar.currentPageMappedIndex) - activeItemDisplacement
		}
		
		self.mappedNodes[TabBar.currentPageMappedIndex]!.setScale(1.3 - 0.3 * abs(activeItemDisplacement))
	}
	
	public func resetActiveItem() {
		self.animatedActiveItemChange(to: TabBar.currentPageMappedIndex)
	}
	
	public func animatedActiveItemChange(to mappedIndex: Int) {
		//	Move the activeItemNode to the targeted position
		let animation = SKAction.moveTo(x: self.itemsDistance * mappedIndex, duration: 0.3)
		animation.timingMode = .easeInEaseOut
		self.activeItemNode.run(animation)
		
		//	Upscale the target itemNode
		let upscaleAnimation = SKAction.scale(to: 1.3, duration: 0.3)
		upscaleAnimation.timingMode = .easeInEaseOut
		self.mappedNodes[mappedIndex]!.run(upscaleAnimation)
		
		//	Downscale the previous itemNode
		let downscaleAnimation = SKAction.scale(to: 1.0, duration: 0.3)
		downscaleAnimation.timingMode = .easeInEaseOut
		self.mappedNodes[TabBar.previousActiveItemIndex]!.run(downscaleAnimation)
		
		//	Colorize the active itemNode
		let colorizeTargetNodeAnim: SKAction = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0.3)
		self.mappedNodes[mappedIndex]!.run(colorizeTargetNodeAnim)
		
		//	Colorize the previous itemNode
		let colorizePreviousNodeAnim: SKAction = SKAction.colorize(with: ColorPalette.darkest, colorBlendFactor: 1.0, duration: 0.3)
		self.mappedNodes[TabBar.previousActiveItemIndex]!.run(colorizePreviousNodeAnim)
	}
	
	static public func mapIndex(index: Int) -> Int {
		//	Pages array interval: 0...n
		//	Actual translation index necessary:
		//		- Middle point: 0
		//		- To the right: n+1
		//		- To the left: n-1
		//	Example
		//
		//	Page array: 			0, 1, 2, 3, 4
		//	Translation indices:	2, 1, 0, -1, -2
		//
		//	Mapping first gets the cardinality of the neighbourhood centered at the mid point of the page array (if odd it subtracts one),
		//	in this example it would be 2 (3,4 & 0,1), subtracts the cardinality from the passed index (i.e. 3 => 3 - 2 = 1) and multiplies
		//	by -1 to respect SpriteKit's coordinate space.
		if TabBar.pages % 2 == 0 {
			return (index - TabBar.pages / 2) * -1
		}
		return (index - (TabBar.pages - 1) / 2) * -1
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

fileprivate class TabBarItem: SKSpriteNode {
	/// Create a new TabBarItem.
	/// - Parameters:
	///   - padding: either positive (last element) or negative (first element). Set nil for neither first nor last
	init(textureName: String) {
		super.init(
			texture: SKTexture(imageNamed: textureName),
			color: ColorPalette.darkest,
			size: CGSize(
				width: 	References.shared.deviceFrame.height / 12 * 182 / 202,
				height: References.shared.deviceFrame.height / 12
			)
		)
		
		self.colorBlendFactor = 1.0
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

