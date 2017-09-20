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

    public enum PinType {
        // case pin
        // case customPin
        case circle(CGFloat)
        case none
    }

    var pinLocation: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet {
            pin?.location = pinLocation
        }
    }
    var pin: Pin?

    public init(frame: CGRect,
                centerCoordinate: CLLocationCoordinate2D,
                span: MKCoordinateSpan,
                pinType: PinType = .none) {
        super.init(frame: frame)

        self.isScrollEnabled = false
        self.isPitchEnabled = false

        let region = MKCoordinateRegionMake(centerCoordinate, span)
        self.region = region

        switch pinType {
        case .circle(let radius):
            pin = CircleView(
                radius: radius,
                center: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            )
            self.addSubview(pin as! UIView)
        default:
            break
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
