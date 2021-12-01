//
//  DetailVC.swift
//  RickMortyV2
//
//  Created by Jugurtha Kabeche on 25/11/2021.
//

import UIKit

class DetailVC: UIViewController {
    
    var character: RMCharacter?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var labelAlive: UILabel!
    @IBOutlet weak var labelOrigin: UILabel!
    @IBOutlet weak var labelSpecies: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let character = character {
            if let urlString = character.image, let url = URL(string: urlString) {
                charImageView.af.setImage(withURL: url)
                nameLabel.text = character.name
                labelAlive.text = character.status
                labelOrigin.text = character.originName
                labelSpecies.text = character.species
            }
        }
        
        
        
        // Do any additional setup after loading the view.
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
