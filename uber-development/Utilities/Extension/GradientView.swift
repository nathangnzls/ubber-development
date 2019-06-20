//
//  GradientView.swift
//  uber-development
//
//  Created by Nathan on 05/04/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit

class GradientView: UIView {
    let gradient = CAGradientLayer()
    override func awakeFromNib() {
        setUpGradientView()
    }
    func setUpGradientView(){
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor,UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.8,1.0]
        self.layer.addSublayer(gradient)
    }

}
