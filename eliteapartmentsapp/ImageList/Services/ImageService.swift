//
//  ImageService.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import Foundation

class ImageService: ImageServiceProtocol {
    private let repository: ImageRepositoryProtocol

    init(repository: ImageRepositoryProtocol = ImageRepository()) {
        self.repository = repository
    }

    func fetchImages() -> [ImageModel] {
        return repository.fetchImages()
    }

    func saveImage(_ image: ImageModel) {
        repository.saveImage(image)
    }

    func deleteImage(_ image: ImageModel) {
        repository.deleteImage(image)
    }
}
