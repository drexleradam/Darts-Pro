//
//  ViewController.swift
//  Darts Pro
//
//  Created by Ádám Drexler on 2019. 11. 10..
//  Copyright © 2019. Ádám Drexler. All rights reserved.
//

import UIKit

struct Keys {
	static let playersArray = "playersArray";
	static let activePlayersArray = "activePlayersArray";
}

struct GameModes {
	static let threeHundredOne = "301"
	static let fiveHundredOne = "501"
	static let ckricket = "Cricket"
}

class ViewController: UIViewController {

	@IBOutlet weak var newGameButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if (UserDefaults.standard.array(forKey: Keys.playersArray) == nil) || UserDefaults.standard.array(forKey: Keys.playersArray)!.count == 0 {
			newGameButton.isEnabled = false
		} else {
			newGameButton.isEnabled = true
		}
	}

}
