//
//  CharacterCVC.swift
//  RickMortyV2
//
//  Created by Jugurtha Kabeche on 25/11/2021.
//

import UIKit
import Alamofire
import ObjectMapper
private let reuseIdentifier = "CharacterCollectionCell"

class CharacterCVC: UICollectionViewController {

    var characters: Array<RMCharacter>?
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.collectionView!.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        downloadAndParse()
        

        // Do any additional setup after loading the view.
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
                                self.collectionView.reloadData()
                            }
                        }
                    }
                    //TODO: save the results and display them in the tableView
                }
            }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CharacterCollectionCell else {
            fatalError("missing cell")
        }
        let character = characters?[indexPath.row]
        if let character = character {
            cell.displayChar(char: character)
        }

        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CVCSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = collectionView.indexPathsForSelectedItems?[0]
        if segue.identifier == "CVCSegue" {
            if let destination = segue.destination as? DetailVC {
                destination.character = characters![indexPath!.row]
            }
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

private let itemsPerRow: CGFloat = 2
private let lineSpacing: CGFloat = 12
private let itemSpacing: CGFloat = 12
private let sectionInsets = UIEdgeInsets(
    top: 15.0,
    left: 15.0,
    bottom: 15.0,
    right: 15.0)
extension CharacterCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = itemSpacing * (itemsPerRow - 1) + sectionInsets.left + sectionInsets.right
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 2.0 / 3.0)
    }
}
