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
	var player1Score = 0
	var player2Score = 0
	
	var actualScore = 0
	var isGameRunning = true
	
	var gameMode = GameModes.threeHundredOne
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		isGameRunning = true
		
		topNavigationItem.title = gameMode

		player1Label.text = players[0]
		player2Label.text = players[1]
		
		player1Score = Int(gameMode) ?? 302
		player2Score = Int(gameMode) ?? 302
		
		self.resetScores()
		self.setLabels()
    }
	
	func setLabels() {
		if isGameRunning {
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
		var tmp : Int
		if !turn {
			tmp = player1Score - actualScore
			if tmp > 0 {
				player1Score = tmp
			} else if tmp == 0 {
				player1Score = tmp
				isGameRunning = false
				winGame(playerName: player1Label.text!)
			}
		} else {
			tmp = player2Score - actualScore
			if tmp > 0 {
				player2Score = tmp
			} else if tmp >= 0 {
				player2Score = tmp
				isGameRunning = false
				winGame(playerName: player2Label.text!)
			}
		}
		actualScore = 0
	}
	
	func showToast(message : String, font: UIFont) {
		let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
		toastLabel.backgroundColor = UIColor.systemYellow.withAlphaComponent(1)
		toastLabel.textColor = UIColor.black
		toastLabel.font = font
		toastLabel.textAlignment = .center;
		toastLabel.text = message
		toastLabel.alpha = 1.0
		toastLabel.layer.cornerRadius = 10;
		toastLabel.clipsToBounds  =  true
		self.view.addSubview(toastLabel)
		UIView.animate(withDuration: 2.0, delay: 0.6, options: .curveEaseOut, animations: {
			 toastLabel.alpha = 0.0
		}, completion: {(isCompleted) in
			toastLabel.removeFromSuperview()
		})
	}
	
	func winGame(playerName : String) {
		let alert = UIAlertController(title: "\(playerName) won!", message: nil, preferredStyle: .alert)
		let okBtn = UIAlertAction(title: "Well done!", style: .default) {
			(UIAlertAction) in
			self.navigationController?.popViewController(animated: true)
		}
        alert.addAction(okBtn)
        
        present(alert, animated: true)
	}
	
	func validScore(aScore: Int, realScore: Int) -> Bool{
		if aScore <= 180 && aScore <= realScore {
			return true
		}
		return false
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
			if actualScore == 0 {
				setLabels()
				showToast(message: "No score.", font: UIFont.systemFont(ofSize: 18))
			} else if validScore(aScore: actualScore, realScore: turn ? player2Score: player1Score ) {
				calculateScore()
				resetScores()
				setLabels()
			} else {
				showToast(message: "Invalid score!", font: UIFont.systemFont(ofSize: 18))
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
			showToast(message: "How did you do that?", font: UIFont.systemFont(ofSize: 18))
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
