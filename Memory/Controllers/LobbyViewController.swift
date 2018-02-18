//
//  LobbyViewController.swift
//  Memory
//
//  Created by Raul Silva on 2/17/18.
//  Copyright © 2018 Silva. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    @IBAction func gridSizeSelected(_ sender: UIButton) {
        if let label = sender.titleLabel?.text{
            let digit1 = Int((label.first? .description)!)!
            let digit2 = Int((label.last? .description)!)!
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "gameView") as! GameViewController
            Manager.shared.grid = [digit1,digit2]
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
