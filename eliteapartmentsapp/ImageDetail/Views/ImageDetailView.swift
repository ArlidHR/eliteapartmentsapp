//
//  ImageDetailView.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import SwiftUI

struct ImageDetailView: View {
    @ObservedObject var viewModel: ImageDetailViewModel

    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: viewModel.image.imageData) ?? UIImage())
                .resizable()
                .scaledToFit()
            Text(ImageDetailStrings.DetailView.nameTitle + "\(viewModel.image.name)")
                .font(.title)
                .padding()
            Text(ImageDetailStrings.DetailView.sizeTitle + "\(viewModel.image.imageData.count)" + ImageDetailStrings.DetailView.bytes)
                .font(.title2)
                .padding()
            Text(ImageDetailStrings.DetailView.dateAddedTitle + "\(viewModel.image.dateAdded)")
                .font(.title2)
                .padding()
        }
        .navigationTitle(ImageDetailStrings.DetailView.navigationTitle)
    }
}
