//
//  ImageListView.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import SwiftUI
import Photos

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ImageListView: View {
    @ObservedObject var viewModel: ImageListViewModel
    @State private var isImagePickerPresented = false
    @State private var selectedImage = UIImage()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.images.indices, id: \.self) { index in
                    if let uiImage = UIImage(data: viewModel.images[index].imageData) {
                        NavigationLink(destination: ImageDetailView(viewModel: ImageDetailViewModel(image: viewModel.images[index]))) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteImage)
            }
            .navigationBarItems(trailing: Button(action: {
                let status = PHPhotoLibrary.authorizationStatus()
                if status == .notDetermined {
                    PHPhotoLibrary.requestAuthorization { newStatus in
                        if newStatus == .authorized {
                            isImagePickerPresented = true
                        }
                    }
                } else if status == .authorized {
                    isImagePickerPresented = true
                }
            }) {
                Image(systemName: ImageListStrings.View.systemName)
            })
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
        .onChange(of: selectedImage) { newImage in
            if let imageData = newImage.jpegData(compressionQuality: 0.5) {
                viewModel.addImage(with: imageData)
            }
        }
    }
}

#Preview {
    ImageListView(viewModel: ImageListViewModel())
}
