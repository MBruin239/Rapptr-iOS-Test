//
//  CustomButton.swift
//  Rapptr iOS Test
//
//  Created by Michael  Bruin on 8/7/22.
//

import UIKit

class CustomButton: UIButton {
    var cornerRadius: CGFloat = 0 {
        didSet {
           self.layer.cornerRadius = cornerRadius
        }
    }
}
