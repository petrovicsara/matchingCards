//
//  CardModel.swift
//  MatchingCards
//
//  Created by Sara Petrovic on 06/12/2020.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card]{
        
        var cardArray = [Card]()
        var randomNumbers = [Int]()
        
        while randomNumbers.count < 8 {
            let randomNumber = Int.random(in: 1...13)
            if !randomNumbers.contains(randomNumber) {
                randomNumbers.append(randomNumber)
            }
        }
        
        for randomNumber in randomNumbers {
            for _ in 1...2 {
                let card = Card()
                card.imageName = "card\(randomNumber)"
                cardArray.append(card)
            }
        }
        
        return cardArray.shuffled()
    }
}
