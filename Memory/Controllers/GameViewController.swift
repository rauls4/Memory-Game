//
//  GameViewController.swift
//  Memory
//
//  Created by Raul Silva on 2/16/18.
//  Copyright © 2018 Silva. All rights reserved.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController, cardDelegate {
    private var lastCards = [CardView]()
    
    @IBOutlet private weak var rowStack: UIStackView!
    @IBOutlet private weak var guru: UIImageView!
    
    @IBAction private func quit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        Manager.shared.cards = Cards(totalCards: Manager.shared.grid[0] * Manager.shared.grid[1])
        self.initializeBoard()
        guru.isHidden = true
    }
    
    private func initializeBoard(){
        for _ in 1...Manager.shared.grid[1]{
            let colStack = UIStackView()
            colStack.axis = .horizontal
            colStack.spacing = 5
            colStack.distribution = .fillEqually
            for _ in 1...Manager.shared.grid[0] {
                let newCard = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)!.first as! CardView
                newCard.cardData.type = Manager.shared.cards?.stack[0].type
                newCard.delegate = self
                Manager.shared.cards?.stack.remove(at: 0)
                colStack.addArrangedSubview(newCard)
            }
            rowStack.addArrangedSubview(colStack)
        }
    }
    
    func didRevealCard(selectedCard: CardView) {
        if(lastCards.count == 2) {
            if(lastCards[0].cardData.type == lastCards[1].cardData.type){
                lastCards = [CardView]()
            }else{
                for card in lastCards{
                    card.flipCard()
                }
            }
            lastCards = [selectedCard]
        }else{
            if(lastCards.count == 1){
                if (lastCards[0].cardData.type == selectedCard.cardData.type){
                    self.highliteCard(card: lastCards[0])
                    self.highliteCard(card: selectedCard)
                    Manager.shared.score = Manager.shared.score + 2
                    if (Manager.shared.score == Manager.shared.grid[0] * Manager.shared.grid[1]){
                        SoundHelper.playSound(name: "magic")
                        self.animateGuru()
                    }else{
                        SoundHelper.playSound(name: "blop")
                        Manager.shared.cardsRevealed = 0
                    }
                    lastCards = [CardView]()
                }else{
                    let flippers = [self.lastCards[0],selectedCard]
                    self.lastCards = [CardView]()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        flippers[0].flipCard()
                        flippers[1].flipCard()
                    })
                }
            }else{
                lastCards.append(selectedCard)
            }
        }
    }
    
    private func highliteCard(card:CardView){
        card.alpha = 0.5
    }
    
    private func animateGuru(){
        guru.alpha = 0
        guru.isHidden = false
        let guruOrigin = guru.center.y
        UIView.animate(withDuration: 2, animations: {
            self.guru.alpha = 1
            self.guru.center.y = guruOrigin - 20
        })
    }
}
