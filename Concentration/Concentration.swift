//
//  Concentration.swift
//  Concentration
//
//  Created by Terry Wang on 2017-11-30.
//  Copyright © 2017 Terry Wang. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
        assert(numberOfPairsOfCard > 0, "Concentration.init(\(numberOfPairsOfCard)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        self.shuffleTheCards()
    }
    
    mutating func restartGame(){
        for cardIndex in cards.indices {
            cards[cardIndex].isFaceUp = false
            cards[cardIndex].isMatched = false
        }
        self.shuffleTheCards()
    }
    
    mutating func shuffleTheCards(){
        var shuffuledCards = [Card]()
        for _ in 1..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffuledCards.append(cards.remove(at: randomIndex))
        }
        shuffuledCards.append(cards.remove(at: 0))
        cards += shuffuledCards
    }
    
}
