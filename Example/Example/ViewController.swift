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

        let view: SearchableMapView = SearchableMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        self.view.addSubview(view)

        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.64225261994919, 139.71363692266726)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let preview: PreviewableMapView = PreviewableMapView(frame: CGRect(x: 0, y: 320, width: self.view.frame.width, height: 200), centerCoordinate: center, span: span)
        self.view.addSubview(preview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

