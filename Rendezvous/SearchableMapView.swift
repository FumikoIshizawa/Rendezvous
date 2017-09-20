//
//  SearchableMapView.swift
//  Rendezvous
//
//  Created by fumiko-ishizawa on 2017/09/20.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import Foundation

import MapKit

public class SearchableMapView: MKMapView {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        let view: UIView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        self.addSubview(view)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
