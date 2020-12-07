//
//  ViewController.swift
//  MatchingCards
//
//  Created by Sara Petrovic on 06/12/2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cards = [Card]()
    var firstFlippedCardIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards = model.getCards()
        
        //set the ViewController as delegate and the datasource
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    //MARK: - Collection View delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let customCell = cell as? CardCollectionViewCell
        customCell?.configureCell(card: cards[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            cell?.flipUp()
            
            if firstFlippedCardIndex == nil {
                //the first card is flipped
                firstFlippedCardIndex = indexPath
            } else {
                checkIfMatch(secondFlippedCardIndex: indexPath)
            }
        }
        
    }
    //MARK: - Game logic methods
    
    func checkIfMatch(secondFlippedCardIndex: IndexPath) {
        let card1 = cards[firstFlippedCardIndex!.row]
        let card2 = cards[secondFlippedCardIndex.row]
        let card1Cell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let card2Cell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        if  card1.imageName == card2.imageName {
            card1.isMatched = true
            card2.isMatched = true
            card1Cell?.remove()
            card2Cell?.remove()
        } else {
            card1.isFlipped = false
            card2.isFlipped = false
            card1Cell?.flipDown()
            card2Cell?.flipDown()
        }
        
        firstFlippedCardIndex = nil
    }

}

