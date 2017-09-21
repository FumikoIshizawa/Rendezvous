//
//  CircleView.swift
//  Rendezvous
//
//  Created by fumiko-ishizawa on 2017/09/20.
//  Copyright © 2017年 fumikoi. All rights reserved.
//

import Foundation

class CircleView: UIView, Pin {

    var radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = radius
            self.frame.size = CGSize(width: 2 * radius, height: 2 * radius)
        }
    }
    var location: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            self.center = location
        }
    }

    init(radius: CGFloat, center: CGPoint) {
        super.init(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius))

        self.radius = radius
        self.layer.cornerRadius = radius
        self.frame.size = CGSize(width: 2 * radius, height: 2 * radius)
        self.location = center
        self.center = center

        // TODO: Configure
        self.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.1960784314, blue: 0.02745098039, alpha: 0.5)
        self.layer.borderColor = #colorLiteral(red: 0.9137254902, green: 0.1960784314, blue: 0.02745098039, alpha: 1)
        self.layer.borderWidth = 2.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
