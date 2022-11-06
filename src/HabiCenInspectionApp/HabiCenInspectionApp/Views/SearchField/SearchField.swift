//
//  SearchField.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 22/07/2022.
//
import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    var placeholder: String

    init(searchText: Binding<String>, placeholder: String) {
        _searchText = searchText
        self.placeholder = placeholder
    }

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.Label.secondary)
            TextField(placeholder, text: self.$searchText)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.HabiCen.body)
                .foregroundColor(.Label.secondary)
                .overlay(
                    Image(systemName: "mic.fill")
                        .foregroundColor(.Label.secondary),
                    alignment: .trailing
                )
        }
        .font(.HabiCen.body)
        .padding(.horizontal, 7)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.SystemFill.tertiary)
        )
    }
}
