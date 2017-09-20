//
//  PreviewableMapView.swift
//  Rendezvous
//
//  Created by fumiko-ishizawa on 2017/09/20.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import Foundation

import MapKit

public class PreviewableMapView: MKMapView {

    public init(frame: CGRect, centerCoordinate: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        super.init(frame: frame)

        let region = MKCoordinateRegionMake(centerCoordinate, span)
        self.region = region
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
