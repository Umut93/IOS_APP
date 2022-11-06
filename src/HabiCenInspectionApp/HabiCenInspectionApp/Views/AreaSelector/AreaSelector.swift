//
//  AreaSelector.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 01/08/2022.
//

import SwiftUI

struct AreaSelector: View {
    @Binding var selectedArea: Area

    init(selectedArea: Binding<Area>) {
        _selectedArea = selectedArea
    }

    var body: some View {
        Picker("Area", selection: $selectedArea) {
            ForEach(Area.allCases) { area in
                if area == selectedArea {
                    Image(area.rawValue + "Solid")
                } else {
                    Image(area.rawValue + "Regular")
                }
            }
        }
        .frame(height: 56)
        .pickerStyle(.segmented)

        Text(selectedArea == Area.inspection ? "areaSelector.header.inspections" : "areaSelector.header.deficiencies")
            .font(.HabiCen.titleBold)
            .frame(maxWidth: .infinity, alignment: .leading)

        Divider()
            .background(Color.Separator.opaque)
            .padding(.bottom, 16)
    }
}

extension AreaSelector {
    enum Area: String, CaseIterable, Identifiable {
        case inspection = "Inspection"
        case deficency = "Deficiency"
        var id: Self { self }
    }
}
