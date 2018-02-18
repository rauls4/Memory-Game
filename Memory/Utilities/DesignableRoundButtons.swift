//
//  DesignableRoundButtons.swift
//  Memory
//
//  Created by Raul Silva on 2/17/18.
//  Copyright © 2018 Silva. All rights reserved.
//

import UIKit

@IBDesignable

class DesignableRoundButtons: UIButton {

    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }

    
}
