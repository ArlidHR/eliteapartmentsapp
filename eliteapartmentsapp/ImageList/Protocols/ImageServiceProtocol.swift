//
//  ImageServiceProtocol.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import Foundation

protocol ImageServiceProtocol {
    func fetchImages() -> [ImageModel]
    func saveImage(_ image: ImageModel)
    func deleteImage(_ image: ImageModel)
}
