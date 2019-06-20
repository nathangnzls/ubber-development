//
//  PassengerHomeViewController.swift
//  uber-development
//
//  Created by Nathan on 05/04/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit
import MapKit
class PassengerHomeViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myLocIcon: UIView!
    @IBOutlet weak var myDestinationIcon: UIView!
    @IBOutlet weak var myLocationTF: UITextField!
    @IBOutlet weak var myDestinationTF: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var requestRideBtn: RoundedButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var destinationViewHolder: UIView!
    var delegate: centerVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpviews()
        mapView.delegate = self
    }
    
    func setUpviews(){
        self.requestRideBtn.makeCircular()
        self.destinationViewHolder.layer.cornerRadius = 10
        self.destinationViewHolder.dropShadow()
        self.requestRideBtn.dropShadow()
        self.profileImg.makeCircular()
    }
    @IBAction func rqstPressed(_ sender: Any) {
        self.requestRideBtn.animateButton(shouldLoad: true, withMessage: "")
    }
    @IBAction func menu(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
}
