//
//  CharacterTVC.swift
//  RickMortyV2
//
//  Created by Jugurtha Kabeche on 25/11/2021.
//

import UIKit
import Alamofire
import AlamofireImage
import ObjectMapper
class CharacterTVC: UITableViewController {
    
    var characters: Array<RMCharacter>?
    private let cellName = "CharacterCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: cellName, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: cellName)
        downloadAndParse()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func downloadAndParse() {
        AF.request("https://rickandmortyapi.com/api/character")
            .validate(statusCode: 200..<300)
            .responseString { response in
                if let charResponse = Mapper<RMCharacterResponse>().map(JSONString: response.value!) {
                    if let results = charResponse.results {
                        print("got \(results.count) characters from the API")
                        self.characters = results
                        
                        DispatchQueue.main.async {
                            do {
                                self.tableView.reloadData()
                            }
                        }
                    }
                    //TODO: save the results and display them in the tableView
                }
            }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.characters?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? CharacterCell else {
            fatalError("missing cell")
        }
        
        let character = characters?[indexPath.row]
        if let character = character {
            cell.displayChar(char: character)
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.defaultHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailVC {
                destination.character = characters![indexPath!.row]
            }
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
