//
//  LoginVC.swift
//  uber-development
//
//  Created by Nathan on 27/06/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func signin(_ sender: Any) {
        if tfEmail.text != nil && tfPassword.text != nil{
            //proceed login auth
            if let email = self.tfEmail.text, let password = self.tfPassword.text{
                Auth.auth().signIn(withEmail: email , password: password, completion:{ (user, error) in
                    if error == nil{
                        if let user = user{
                            if self.segmentedControl.selectedSegmentIndex == 0{
                                let userData = ["provider": user.user.providerID] as [String:Any]
                                DataService.dataService.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                            }else{
                                let userData = ["provider": user.user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String:Any]
                                DataService.dataService.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user successfully with firebase")
                        self.dismiss(animated: true, completion: nil)
                    }else{ 
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil{
                                if let errorCode = AuthErrorCode(rawValue: error!._code){
                                    switch errorCode{
                                    case .invalidEmail:
                                        print("invalid email address")
                                    case .emailAlreadyInUse:
                                        print("email exist, try again")
                                    case .wrongPassword:
                                        print("wrong password")
                                    default:
                                        print("unexpected error, please try again")
                                    }
                                }
                            }else{
                                if let user = user{
                                    if self.segmentedControl.selectedSegmentIndex == 0{
                                        let userData = ["provider": user.user.providerID] as [String:Any]
                                        DataService.dataService.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                                    }else{
                                        let userData = ["provider": user.user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String:Any]
                                        DataService.dataService.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                                    }
                                }
                                print("successfully created new user")
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
}
