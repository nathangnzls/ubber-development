//
//  CircleView.swift
//  uber-development
//
//  Created by Nathan on 05/04/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit

class CircleView: UIView {
    @IBInspectable var borderColor: UIColor?{
        didSet{
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        setUpView()
    }
    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }
}
