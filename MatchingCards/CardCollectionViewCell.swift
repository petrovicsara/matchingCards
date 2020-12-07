//
//  CardCollectionViewCell.swift
//  MatchingCards
//
//  Created by Sara Petrovic on 06/12/2020.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontOfCard: UIImageView!
    @IBOutlet weak var backOfCard: UIImageView!
    
    var card: Card?
    
    func configureCell(card:Card) {
        self.card = card
        frontOfCard.image = UIImage(named: card.imageName)
        
        if card.isMatched == true {
            backOfCard.alpha = 0
            frontOfCard.alpha = 0
            return
        } else {
            backOfCard.alpha = 1
            frontOfCard.alpha = 1
        }
        
        if card.isFlipped {
            flipUp(duration: 0)
        } else {
            flipDown(duration: 0, delay: 0)
        }
    }
    
    func flipUp(duration: TimeInterval = 0.3) {
        UIView.transition(from: backOfCard, to: frontOfCard, duration: duration, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        card?.isFlipped = true
    }
    
    func flipDown(duration: TimeInterval = 0.3, delay: TimeInterval = 0.5) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            UIView.transition(from: self.frontOfCard, to: self.backOfCard, duration: duration, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
            self.card?.isFlipped = false
        }
    }
    
    func remove() {
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontOfCard.alpha = 0
        }, completion: nil)
    }
}
