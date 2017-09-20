//
//  SearchLocationViewController.swift
//  Example
//
//  Created by fumiko-ishizawa on 2017/09/20.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import UIKit

import MapKit
import Rendezvous

class SearchLocationViewController: UIViewController {

    private lazy var mapView: SearchableMapView = {
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.64225261994919, 139.71363692266726)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let mapView: SearchableMapView = SearchableMapView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.frame.width,
                                              height: self.view.frame.height),
                                centerCoordinate: center,
                                span: span)
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchLocationViewController.didTapCancel(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SearchLocationViewController.didTapDone(_:)))
        navigationItem.rightBarButtonItem = doneButton

        self.view.addSubview(mapView)
    }

    @objc private func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func didTapDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
