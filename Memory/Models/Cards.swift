//
//  Cards.swift
//  Memory
//
//  Created by Raul Silva on 2/17/18.
//  Copyright © 2018 Silva. All rights reserved.
//

import Foundation

struct Cards {
    var stack = [Card]()
    //This will hold our complete, shuffled stack of cards
    private var animals = ["Bat","Cat","Cow","GhostDog","Hen","Horse","Pig","Spider","Octopus","Panda"]
    
    init(totalCards:Int) {
        //We need to indicate the total amount of cards so we don't end up with mistmatched cards on the deck
        if(totalCards > (animals.count * 2)){
            //This was occuring in the 4X5 grid (20 cards, with only 8 supplied animals, I added a couple more)
            debugPrint("Game requires more cards than there are pairs")
        }else{
            let limitedAnimals = animals.enumerated().flatMap{ $0.offset < (totalCards/2) ? $0.element : nil } //limit pairs to our max
            for animal in limitedAnimals {
                for _ in 0...1{
                    let newCard = Card(type: animal, showingBack: true)
                    stack.append(newCard)
                    //add the new card to the deck
                }
            }
            self.shuffleStack()
            //and shuffle it
        }
    }
    
    private mutating func shuffleStack(){
        //this uses a modified Fisher-Yates algorithm to sort the array in place,
        //not really necessary for a maximum of 20 cards, but what the heck
        var last = stack.count - 1
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            stack.swapAt(last, rand)
            last -= 1
        }
    }
}
