//
//  Image+Extension.swift
//  eliteapartmentsapp
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import SwiftUI

extension Image {
    init(data: Data) {
        self.init(uiImage: UIImage(data: data) ?? UIImage())
    }
}
