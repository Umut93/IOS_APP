//
//  UISegmentedControl.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 04/08/2022.
//

import Foundation
import UIKit

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
