//
//  XibInstantiable.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 30.08.2022.
//

import UIKit

protocol XibInstantiable {
    associatedtype CustomViewType
    static func loadFromXib() -> CustomViewType
}

extension XibInstantiable where Self: UIView {
    static func loadFromXib() -> Self {
        let nib = UINib(nibName: "\(self)", bundle: Bundle(for: self))
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            preconditionFailure("Couldn't load xib for view: \(self)")
        }
        return customView
    }
}

