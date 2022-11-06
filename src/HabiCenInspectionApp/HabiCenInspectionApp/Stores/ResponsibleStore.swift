//
//  ResponsibleStore.swift
//  HabiCenInspectionApp
//
//  Created by Umut Kayatuz on 03/08/2022.
//

import Foundation

protocol ResponsibleStore {
    func fetch() -> [Responsible]
}

final class MockResponsibleStore: ResponsibleStore {
    func fetch() -> [Responsible] {
        return [
            Responsible(identifier: "1", name: "Me", IsUserLoggedin: true),
            Responsible(identifier: "ncw", name: "Nikolaj Coster-Waldau", IsUserLoggedin: false),
            Responsible(identifier: "umut", name: "Umut Kayatuz", IsUserLoggedin: false),
            Responsible(identifier: "ulrik", name: "Ulrik Søvsø Larsen", IsUserLoggedin: false),
            Responsible(identifier: "mik", name: "Mikkel Brøgger Jensen", IsUserLoggedin: false),
            Responsible(identifier: "kbh", name: "Kristian Handberg", IsUserLoggedin: false),
            Responsible(identifier: "blz", name: "Bartholomew Zhykhareiv", IsUserLoggedin: false)
        ]
    }
}
