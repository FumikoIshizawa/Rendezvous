//
//  SearchableMapViewController.swift
//  Rendezvous
//
//  Created by fumiko-ishizawa on 2017/09/21.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import Foundation

import CoreLocation
import MapKit

public class SearchableMapViewController: UIViewController {

    public var updatedLocation: ((CLPlacemark) -> Void)?
    public var span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
    public var center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35, 139)
    public var pinType: SearchableMapView.PinType = .none
    public var searchText: String = "Search"
    public var hasSearchField: Bool = true

    internal lazy var mapView: SearchableMapView = {
        let center: CLLocationCoordinate2D = self.center
        let span: MKCoordinateSpan = self.span
        let mapView: SearchableMapView
            = SearchableMapView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.frame.width,
                                              height: self.view.frame.height),
                                centerCoordinate: center,
                                span: span,
                                pinType: self.pinType,
                                searchType: .none)
        return mapView
    }()
    private let textField: UITextField = UITextField()
    private let activityIndicatorView: UIActivityIndicatorView
        = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    private let activityIndicatorBackground: UIView = UIView()
    fileprivate let locationManager: CLLocationManager = CLLocationManager()

    override public func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestLocation()

        if hasSearchField {
            // Search textField
            textField.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 128, height: 32)
            textField.placeholder = self.searchText
            textField.borderStyle = .roundedRect
            textField.returnKeyType = .search
            textField.delegate = self
            self.navigationItem.titleView = textField
        }

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SearchableMapViewController.didTapDone(_:)))
        navigationItem.rightBarButtonItem = doneButton

        self.view.addSubview(mapView)

        activityIndicatorView.center = self.view.center
        activityIndicatorView.isHidden = true
        activityIndicatorBackground.frame = CGRect(x: 0,
                                                   y: 0,
                                                   width: self.view.frame.width,
                                                   height: self.view.frame.height)
        activityIndicatorBackground.backgroundColor = UIColor(white: 0, alpha: 0.5)
        activityIndicatorBackground.isHidden = true
        self.view.addSubview(activityIndicatorBackground)
        self.view.addSubview(activityIndicatorView)

    }

    @objc private func didTapDone(_ sender: Any) {
        mapView.fetchPlacemark { [weak self] (placemark) in
            self?.updatedLocation?(placemark)
        }
        self.dismiss(animated: true, completion: nil)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }

    fileprivate func showActivityIndicator() {
        activityIndicatorBackground.isHidden = false
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    fileprivate func hideActivityIndicator() {
        activityIndicatorBackground.isHidden = true
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }

}


// MARK: - UITextField Delegate
extension SearchableMapViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.showActivityIndicator()

        let request: MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = textField.text
        MKLocalSearch(request: request).start { [weak self] (response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let result = response?.mapItems.first else { return }
            guard let location = result.placemark.location else { return }
            self?.mapView.centerLocation = location
            self?.hideActivityIndicator()
        }
        return true
    }

}


// MARK: - CLLocationManager Delegate
extension SearchableMapViewController: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = locations.first else {
            return
        }
        self.mapView.centerLocation = location
    }
}

