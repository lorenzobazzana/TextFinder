//
//  IdentifiableImage.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import PhotosUI

class IdentifiableImage: Identifiable{
    
    let img: UIImage
    let id: UUID
    
    init(img: UIImage) {
        self.img = img
        self.id = UUID()
    }
    
}
