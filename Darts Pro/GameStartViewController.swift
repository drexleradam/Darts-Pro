//
//  GameStartViewController.swift
//  Darts Pro
//
//  Created by Ádám Drexler on 2019. 11. 11..
//  Copyright © 2019. Ádám Drexler. All rights reserved.
//

import UIKit

class GameStartViewController: UIViewController {
	
	let defaults = UserDefaults.standard
	var selectedPlayer = String()

	@IBOutlet weak var activePlayerView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.activePlayerView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
		
		activePlayerView.delegate = self
        activePlayerView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
	@IBAction func addPlayerToTheGame(_ sender: Any) {
		
        let alert = UIAlertController(title: "Add Player To Match", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (UIAlertAction) in
            
			var players = self.defaults.array(forKey: Keys.activePlayersArray) as? [String] ?? []
			
			players.append(self.selectedPlayer)
			
			self.defaults.set(players, forKey: Keys.activePlayersArray)
			
			self.activePlayerView.reloadData()
        
        }))
        self.present(alert,animated: true, completion: nil )
		
	}

}

extension GameStartViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
		let players = self.defaults.array(forKey: Keys.activePlayersArray)
		
		return players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
        let players = self.defaults.array(forKey: Keys.activePlayersArray)
		
		cell.textLabel?.text = players![indexPath.row] as? String

        return cell
        
    }
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			
			var players = self.defaults.array(forKey: Keys.activePlayersArray) as? [String] ?? []
			
			players.remove(at: indexPath.row)
			
			self.defaults.set(players, forKey: Keys.activePlayersArray)
			
			tableView.deleteRows(at: [indexPath], with: .fade)
			
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
	
}

extension GameStartViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		selectedPlayer = self.defaults.array(forKey: Keys.playersArray)![0] as! String
		return 1
	}
	 
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.defaults.array(forKey: Keys.playersArray)?.count ?? 0
	}
		
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return self.defaults.array(forKey: Keys.playersArray)![row] as? String
	}
		
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.selectedPlayer = self.defaults.array(forKey: Keys.playersArray)![row] as! String
	}
	
}
