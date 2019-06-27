//
//  LeftSidePanelVC.swift
//  uber-development
//
//  Created by Nathan on 20/06/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit

class LeftSidePanelVC: UIViewController {

    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func login(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
}
