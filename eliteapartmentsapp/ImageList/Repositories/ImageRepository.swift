//
//  ImageRepository.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import Foundation

class ImageRepository: ImageRepositoryProtocol {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func fetchImages() -> [ImageModel] {
        guard let data = userDefaults.data(forKey: ImageListStrings.Repository.imagesKey) else { return [] }
        let decoder = JSONDecoder()
        return (try? decoder.decode([ImageModel].self, from: data)) ?? []
    }

    func saveImage(_ image: ImageModel) {
        var images = fetchImages()
        images.append(image)
        let encoder = JSONEncoder()
        let data = try? encoder.encode(images)
        userDefaults.set(data, forKey: ImageListStrings.Repository.imagesKey)
    }

    func deleteImage(_ image: ImageModel) {
        var images = fetchImages()
        images.removeAll { $0.id == image.id }
        let encoder = JSONEncoder()
        let data = try? encoder.encode(images)
        userDefaults.set(data, forKey: ImageListStrings.Repository.imagesKey)
    }
}
