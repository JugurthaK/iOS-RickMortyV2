//
//  CharacterCell.swift
//  RickMortyV2
//
//  Created by Jugurtha Kabeche on 25/11/2021.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    static let defaultHeight: CGFloat = 150
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    func displayChar(char: RMCharacter) {
        //display whatever properties needed
        if let urlString = char.image, let url = URL(string: urlString) {
            characterImage.af.setImage(withURL: url)
            firstNameLabel.text = char.name
            raceLabel.text = char.species
            originLabel.text = char.originName
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
