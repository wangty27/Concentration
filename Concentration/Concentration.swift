//
//  Concentration.swift
//  Concentration
//
//  Created by Terry Wang on 2017-11-30.
//  Copyright © 2017 Terry Wang. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        self.shuffleTheCards()
    }
    
    func restartGame(){
        for cardIndex in cards.indices {
            cards[cardIndex].isFaceUp = false
            cards[cardIndex].isMatched = false
        }
        self.shuffleTheCards()
    }
    
    func shuffleTheCards(){
        var shuffuledCards = [Card]()
        for _ in 1..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffuledCards.append(cards.remove(at: randomIndex))
        }
        shuffuledCards.append(cards.remove(at: 0))
        cards += shuffuledCards
    }
    
}
