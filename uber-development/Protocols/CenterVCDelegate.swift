//
//  CenterVCDelegate.swift
//  uber-development
//
//  Created by Nathan on 20/06/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit
import Foundation

protocol centerVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelVC()
    func animateLeftPanel(shouldExpand: Bool)
}
