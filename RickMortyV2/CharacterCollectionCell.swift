//
//  CharacterCollectionCell.swift
//  RickMortyV2
//
//  Created by Jugurtha Kabeche on 25/11/2021.
//

import UIKit
import AlamofireImage
class CharacterCollectionCell: UICollectionViewCell {

    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var charNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func displayChar(char: RMCharacter) {
        //display whatever properties needed
        if let urlString = char.image, let url = URL(string: urlString) {
            charImageView.af.setImage(withURL: url)
            charNameLabel.text = char.name
        }
    }

}
