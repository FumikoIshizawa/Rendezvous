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

    private lazy var preview: PreviewableMapView = {
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.64225261994919, 139.71363692266726)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.015, 0.015)
        let preview: PreviewableMapView
            = PreviewableMapView(frame: CGRect(x: 0, y: 62, width: self.view.frame.width, height: 200),
                                 centerCoordinate: center,
                                 span: span,
                                 pinType: .circle(50))
        return preview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.preview)
    }

    @IBAction func searchLocationButtonTouchUpInside(_ sender: Any) {
        let vc: UINavigationController = {
            let vc: SearchableMapViewController = SearchableMapViewController()
            vc.center = CLLocationCoordinate2DMake(35.64225261994919, 139.71363692266726)
            vc.span = MKCoordinateSpanMake(0.01, 0.01)
            vc.pinType = .circle(100)
            vc.updateLocation = { [weak self] placemark in
                guard let location: CLLocation = placemark.location else { return }
                self?.preview.moveToLocation(coordinate: location.coordinate)
            }
            return UINavigationController(rootViewController: vc)
        }()
        self.present(vc, animated: true, completion: nil)
    }

}

