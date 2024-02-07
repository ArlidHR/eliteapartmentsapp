//
//  ImageModel.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import SwiftUI

struct ImageModel: Identifiable, Codable {
    let id: UUID
    let name: String
    let imageData: Data
    let dateAdded: Date

    init(name: String, imageData: Data, dateAdded: Date) {
        self.id = UUID()
        self.name = name
        self.imageData = imageData
        self.dateAdded = dateAdded
    }
}
