//
//  ViewExtension.swift
//  uber-development
//
//  Created by Nathan on 05/04/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit
import Foundation
extension UIView{
    
    func makeCircular(){
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


