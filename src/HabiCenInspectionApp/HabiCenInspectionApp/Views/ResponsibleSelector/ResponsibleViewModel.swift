//
//  ResponsibleViewModel.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 03/08/2022.
//
import SwiftUI

final class ResponsibleViewModel: ObservableObject {
    private let responsibleStore: ResponsibleStore
    var selectedResponsibles: Binding<[Responsible]>
    @Published var user: Responsible?
    @Published var responsibles: [Responsible] = []
    init(responsibleStore: ResponsibleStore = MockResponsibleStore(), selections: Binding<[Responsible]>) {
        self.responsibleStore = responsibleStore
        selectedResponsibles = selections
        loadResponsibles()
        findLoggedInUser()
    }

    func loadResponsibles() {
        responsibles = responsibleStore.fetch()
    }

    func findLoggedInUser() {
        user = responsibleStore.fetch().first(where: { $0.isUserLoggedIn == true })!
    }

    func addSelectedResponsible(responsible: Responsible?) {
        guard let responsible = responsible else {
            return
        }
        selectedResponsibles.wrappedValue.append(responsible)
    }

    func doInitialLoad() {
        addSelectedResponsible(responsible: user)
    }

    func resetResponsibleSelections() {
        selectedResponsibles.wrappedValue.removeAll()
        selectedResponsibles.wrappedValue.append(user!)
    }
}
