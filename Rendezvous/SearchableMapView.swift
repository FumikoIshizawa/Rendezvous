//
//  SearchableMapView.swift
//  Rendezvous
//
//  Created by fumiko-ishizawa on 2017/09/20.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import Foundation

import Contacts
import MapKit

public class SearchableMapView: MKMapView {

    public enum PinType {
        case circle(CGFloat)
        case none
    }

    public enum SearchType {
        case box(CGRect)
        case none
    }

    public enum GeoError: Error {
        case noPlacemark
    }

    public var centerLocation: CLLocation {
        get {
            return CLLocation(latitude: self.centerCoordinate.latitude, longitude: self.centerCoordinate.longitude)
        }
        set {
            moveToLocation(coordinate: newValue.coordinate)
        }
    }

    internal var pin: Pin?
    private var span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
    internal var defaultCenterViewLength: Double = 1.0
    internal var defaultSpan: Double = 0.01

    public init(frame: CGRect,
                centerCoordinate: CLLocationCoordinate2D,
                span: MKCoordinateSpan,
                pinType: PinType = .none,
                searchType: SearchType = .none) {
        super.init(frame: frame)

        let region = MKCoordinateRegionMake(centerCoordinate, span)
        self.region = region
        self.span = span

        switch pinType {
        case .circle(let radius):
            self.pin = CircleView(
                radius: radius,
                center: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            )
            self.defaultCenterViewLength = Double(radius)
            self.defaultSpan = span.longitudeDelta
            self.delegate = self
            self.addSubview(pin as! UIView)
        default:
            break
        }

        switch searchType {
        case .box(let frame):
            let textBox: SearchTextBox
                = SearchTextBox(frame: frame,
                                searchText: "Search",
                                completion: { [weak self] text in
                                    self?.searchPlacemark(text: text)
                })
            self.addSubview(textBox)
        default:
            break
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public func fetchPlacemark(completion: @escaping ((CLPlacemark) -> Void)){
        let geoCoder: CLGeocoder = CLGeocoder()

        let location: CLLocation = CLLocation(
            latitude: self.centerCoordinate.latitude,
            longitude: self.centerCoordinate.longitude
        )
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print(error)
            }
            guard let placemark: CLPlacemark = placemarks?.first else { return }
            completion(placemark)
        }
    }

    private func searchPlacemark(text: String) {
        let request: MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = text
        MKLocalSearch(request: request).start { [weak self] (response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let response: MKLocalSearchResponse = response else { return }
            guard let result: MKMapItem = response.mapItems.first else { return }
            self?.moveToLocation(coordinate: result.placemark.coordinate)
        }
    }

    private func moveToLocation(coordinate: CLLocationCoordinate2D) {
        let span = self.span
        let region = MKCoordinateRegionMake(coordinate, span)
        self.setRegion(region, animated: true)
    }

}


// MARK: - MKMapView Delegate
// Change size for a circle
extension SearchableMapView: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        guard let centerView: CircleView = pin as? CircleView else {
            return
        }

        let span: MKCoordinateSpan = mapView.region.span
        let size: CGFloat = CGFloat(defaultCenterViewLength * defaultSpan / span.longitudeDelta)
        centerView.radius = size
        centerView.center = mapView.center
    }
}
