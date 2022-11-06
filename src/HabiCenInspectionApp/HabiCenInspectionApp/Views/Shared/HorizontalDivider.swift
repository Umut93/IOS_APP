//
//  HorizontalDivider.swift
//  HabiCenInspectionApp
//
//  Created by Team Rock It on 14/07/2022.
//

import SwiftUI

struct HorizontalDivider: View {

    let color: Color
    let thickness: CGFloat

    var body: some View {
        self.color
            .frame(height: self.thickness)
    }

    init() {
        self.color = .gray10
        self.thickness = 1
    }

    init(color: Color) {
        self.color = color
        self.thickness = 1
    }

    init(color: Color = .gray10, thickness: CGFloat = 1) {
        self.color = color
        self.thickness = thickness
    }
}
