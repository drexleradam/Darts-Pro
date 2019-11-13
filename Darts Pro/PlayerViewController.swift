//
//  PlayerViewController.swift
//  Darts Pro
//
//  Created by Ádám Drexler on 2019. 11. 10..
//  Copyright © 2019. Ádám Drexler. All rights reserved.
//

import UIKit

class PlayerViewController: UITableViewController {
	
	let defaults = UserDefaults.standard
	@IBOutlet var playerView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.playerView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

	@IBAction func savePlayerName(_ sender: Any) {
		let alert = UIAlertController(title: "Add new Player", message: nil, preferredStyle: .alert)
		alert.addTextField { (textField) in
            textField.placeholder = "name"
        }
		let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addBtn = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            if let textField = alert.textFields?[0] {
				if textField.text!.count > 0 {
					let name = textField.text!
					
					var players = self.defaults.array(forKey: Keys.playersArray) as? [String] ?? []
					
					players.append(name)
					
					self.defaults.set(players, forKey: Keys.playersArray)
					
					self.tableView.reloadData()
				}
			}
        }
		alert.addAction(cancelBtn)
        alert.addAction(addBtn)
        
        present(alert, animated: true)
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		let players = self.defaults.array(forKey: Keys.playersArray)
		
		return players?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		let players = self.defaults.array(forKey: Keys.playersArray)
		
		cell.textLabel?.text = players![indexPath.row] as? String

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			
			var players = self.defaults.array(forKey: Keys.playersArray) as? [String] ?? []
			
			players.remove(at: indexPath.row)
			
			self.defaults.set(players, forKey: Keys.playersArray)
			
			tableView.deleteRows(at: [indexPath], with: .fade)
			
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
