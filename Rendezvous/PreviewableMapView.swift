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

    public var pinPoint: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet {
            pin?.location = pinPoint
        }
    }
    private var pin: Pin?
    private var span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)

    public init(frame: CGRect,
                centerCoordinate: CLLocationCoordinate2D,
                span: MKCoordinateSpan,
                pinType: PinType = .none) {
        super.init(frame: frame)

        self.isScrollEnabled = false
        self.isPitchEnabled = false
        self.isZoomEnabled = false
        self.isRotateEnabled = false
        self.span = span
        self.moveToLocation(coordinate: centerCoordinate)

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

    public func moveToLocation(coordinate: CLLocationCoordinate2D) {
        self.moveToLocation(coordinate: coordinate, span: self.span)
    }

    public func moveToLocation(coordinate: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        let region = MKCoordinateRegionMake(coordinate, span)
        self.setRegion(region, animated: true)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
