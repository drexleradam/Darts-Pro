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

class ViewController: UIViewController {

	@IBOutlet weak var newGameButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		if UserDefaults.standard.array(forKey: Keys.playersArray)!.count == 0 {
			newGameButton.isEnabled = false
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if UserDefaults.standard.array(forKey: Keys.playersArray)!.count == 0 {
			newGameButton.isEnabled = false
		} else {
			newGameButton.isEnabled = true
		}
	}


}
