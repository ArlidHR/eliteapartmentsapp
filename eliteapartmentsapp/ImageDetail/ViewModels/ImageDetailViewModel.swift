//
//  ImageDetailViewModel.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import SwiftUI

class ImageDetailViewModel: ObservableObject {
    @Published var image: ImageModel

    init(image: ImageModel) {
        self.image = image
    }
}
