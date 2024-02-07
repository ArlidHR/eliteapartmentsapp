//
//  ImageListViewModel.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import SwiftUI

class ImageListViewModel: ObservableObject {
    private var imageService: ImageServiceProtocol
    
    @Published var images: [ImageModel] {
        didSet {
            let imagesData = images.map {
                [
                    ImageListStrings.ViewModel.nameKey: $0.name,
                    ImageListStrings.ViewModel.imageDataKey: $0.imageData.base64EncodedString(),
                    ImageListStrings.ViewModel.dateAddedKey: $0.dateAdded
                ]
            }
            UserDefaults.standard.set(
                imagesData,
                forKey: ImageListStrings.ViewModel.imagesKey
            )
        }
    }

    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
        if let imagesData = UserDefaults.standard.array(forKey: ImageListStrings.ViewModel.imagesKey) as? [[String: Any]] {
            images = imagesData.compactMap { dict in
                guard let name = dict[ImageListStrings.ViewModel.nameKey] as? String,
                      let imageData = Data(base64Encoded: dict[ImageListStrings.ViewModel.imageDataKey] as? String ?? ""),
                      let dateAdded = dict[ImageListStrings.ViewModel.dateAddedKey] as? Date else {
                    return nil
                }
                return ImageModel(name: name, imageData: imageData, dateAdded: dateAdded)
            }
        } else {
            images = []
        }
    }

    func loadImages() {
        images = imageService.fetchImages()
    }

    func addImage(with imageData: Data) {
        let newImage = ImageModel(name: ImageListStrings.ViewModel.newImageName, imageData: imageData, dateAdded: Date())
        images.append(newImage)
    }
    
    func deleteImage(at offsets: IndexSet) {
        images.remove(atOffsets: offsets)
        let imagesData = images.map {
            [
                ImageListStrings.ViewModel.nameKey: $0.name,
                ImageListStrings.ViewModel.imageDataKey: $0.imageData.base64EncodedString(),
                ImageListStrings.ViewModel.dateAddedKey: $0.dateAdded
            ]
        }
        UserDefaults.standard.set(imagesData, forKey: ImageListStrings.ViewModel.imagesKey)
    }
}
