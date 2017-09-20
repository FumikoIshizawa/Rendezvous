//
//  ViewController.swift
//  Example
//
//  Created by fumiko-ishizawa on 2017/09/20.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import UIKit

import Rendezvous
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.64225261994919, 139.71363692266726)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.015, 0.015)
        let preview: PreviewableMapView
            = PreviewableMapView(frame: CGRect(x: 0, y: 62, width: self.view.frame.width, height: 200),
                                 centerCoordinate: center,
                                 span: span,
                                 pinType: .circle(50))
        self.view.addSubview(preview)
    }

    @IBAction func searchLocationButtonTouchUpInside(_ sender: Any) {
        let vc: UINavigationController = {
            let vc: SearchLocationViewController = SearchLocationViewController()
            return UINavigationController(rootViewController: vc)
        }()
        self.present(vc, animated: true, completion: nil)
    }

}

