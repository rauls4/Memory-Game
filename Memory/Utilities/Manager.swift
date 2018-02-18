//
//  Manager.swift
//  Memory
//
//  Created by Raul Silva on 2/17/18.
//  Copyright © 2018 Silva. All rights reserved.
//

import Foundation

final class Manager {               //Singleton, for now just keeps track of how many cards are flipped to prevent
                                    //player to flip a bunch at a time
    private init() { }
    static let shared = Manager()
    var cards:Cards?
    var cardsRevealed = 0
    var grid = [3,5]
    var score = 0
}
