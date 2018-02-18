//
//  CardView.swift
//  Memory
//
//  Created by Raul Silva on 2/16/18.
//  Copyright © 2018 Silva. All rights reserved.
//

import UIKit

protocol cardDelegate:class{
    func didRevealCard(selectedCard:CardView)
}

class CardView: UIView {
    var cardData:Card!
    weak var delegate:cardDelegate?
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardImageView: UIView!
    
    @IBAction func cardClicked(_ sender: UIButton) {
        if (cardData.showingBack && Manager.shared.cardsRevealed < 2){
            SoundHelper.playSound(name: "card")
            self.flipCard()
        }
    }
    
    func flipCard(){
        var endImage:UIImage!
       
        if(cardData.showingBack){
              endImage = UIImage(named: cardData.type + "image")
            Manager.shared.cardsRevealed =  Manager.shared.cardsRevealed + 1
        }else{
             endImage = UIImage(named: "cardBack")
            Manager.shared.cardsRevealed =  Manager.shared.cardsRevealed - 1
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 1)
        }, completion:{ finished in
            if(finished){
                self.cardImage.image = endImage
                self.cardData.showingBack = !self.cardData.showingBack
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion:{ finished in
                    if(finished){
                        if (!self.cardData.showingBack){
                               self.delegate?.didRevealCard(selectedCard: self)
                        }
                    }})
            }
        }
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        cardData = Card()
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
