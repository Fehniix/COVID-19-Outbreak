//
//  GameViewController.swift
//  COVID-19 Outbreak
//
//  Created by Johnny Bueti on 22/03/2020.
//  Copyright © 2020 Johnny Bueti. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
		if let view = self.view as! SKView? {
			let scene = GameScene(size: view.bounds.size)
			
			//	Set the scale mode to scale to fill the window
			scene.scaleMode 			= .aspectFill
			
			//	Performance optimisation
			view.ignoresSiblingOrder 	= true
			
			//	Show debug info
			if Debug.debugActive {
				view.showsFPS 			= true
				view.showsNodeCount 	= true
			}
			
			//	Experimentation
			//	Preload atlases into memory
			SKTextureAtlas.preloadTextureAtlasesNamed(["Coronavirus"]) {error, atlas in
				view.presentScene(scene)
			}
		}
    }

	//	Force rotation off, the game will exclusively support portrait mode
    override var shouldAutorotate: Bool {
        return false
    }

	//	Force only portrait mode orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait
    }

	//	Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
