//
//  UIView+Extensions.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 28.08.2023.
//

import UIKit.UIView

extension UIView {
    func add(subviews: UIView...) {
        subviews.forEach(addSubview(_:))
    }
}
