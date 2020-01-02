//
//  x01FirstViewController.swift
//  Darts Pro
//
//  Created by Ádám Drexler on 2019. 12. 29..
//  Copyright © 2019. Ádám Drexler. All rights reserved.
//

import UIKit

class x01FirstViewController: UIViewController {
	
	var players = UserDefaults.standard.array(forKey: Keys.activePlayersArray) as? [String] ?? []

	@IBOutlet weak var topNavigationItem: UINavigationItem!
	@IBOutlet weak var player1Label: UILabel!
	@IBOutlet weak var player2Label: UILabel!
	@IBOutlet weak var player1Indicator: UIImageView!
	@IBOutlet weak var player2Indicator: UIImageView!
	@IBOutlet weak var player1ScoreLabel: UILabel!
	@IBOutlet weak var player2ScoreLabel: UILabel!
	
	@IBOutlet weak var number1: UIButton!
	@IBOutlet weak var number2: UIButton!
	@IBOutlet weak var number3: UIButton!
	@IBOutlet weak var number4: UIButton!
	@IBOutlet weak var number5: UIButton!
	@IBOutlet weak var number6: UIButton!
	@IBOutlet weak var number7: UIButton!
	@IBOutlet weak var number8: UIButton!
	@IBOutlet weak var number9: UIButton!
	@IBOutlet weak var number0: UIButton!
	@IBOutlet weak var deleteBtn: UIButton!
	@IBOutlet weak var returnBtn: UIButton!
	
	var turn = true
	var startScore = 301
	var player1Score = 0
	var player2Score = 0
	
	var actualScore = 0
	
	var gameMode = GameModes.fiveHundredOne
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		topNavigationItem.title = gameMode

		player1Label.text = players[0]
		player2Label.text = players[1]
		
		player1Score = Int(gameMode) ?? 302
		player2Score = Int(gameMode) ?? 302
		
		self.resetScores()
		self.setLabels()
        // Do any additional setup after loading the view.
    }
	
	func setLabels() {
		if turn {
			player1Label.textColor = UIColor.white.withAlphaComponent(1)
            player2Label.textColor = UIColor.white.withAlphaComponent(0.5)
            player1Indicator.isHidden = false
            player2Indicator.isHidden = true
		} else {
			player1Label.textColor = UIColor.white.withAlphaComponent(0.5)
            player2Label.textColor = UIColor.white.withAlphaComponent(1)
            player1Indicator.isHidden = true
            player2Indicator.isHidden = false
		}
		turn = !turn
    }
	
	func printOnLabel(){
		if actualScore > 0{
			if !turn {
				player1ScoreLabel.text = actualScore.description
			} else {
				player2ScoreLabel.text = actualScore.description
			}
		}
	}
	
	func resetScores(){
		player1ScoreLabel.text = String(player1Score)
		player2ScoreLabel.text = String(player2Score)
	}
	
	func calculateScore(){
		if !turn {
			player1Score = player1Score - actualScore
		} else {
			player2Score = player2Score - actualScore
		}
		actualScore = 0
	}
	
	func checkScoreOke() -> Bool {
		if actualScore > 180 {
			return false
		}
		return true
	}

	@IBAction func pressButton(_ sender: UIButton) {
		
		switch sender {
		case number1,number2,number3,number4,number5,number6,number7,number8,number9,number0:
			if let text = sender.titleLabel?.text {
				if let textInt = Int(text) {
					actualScore = actualScore * 10 + textInt
				}
			}
			printOnLabel()
			break
		case returnBtn:
			if checkScoreOke() {
				calculateScore()
				resetScores()
				setLabels()
			}
			break
		case deleteBtn:
			actualScore = actualScore / 10
			if actualScore == 0 {
				resetScores()
			} else {
				printOnLabel()
			}
			break
		default:
			print("What the fuck happened ?")
		}
		
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
