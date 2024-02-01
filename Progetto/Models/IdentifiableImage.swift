//
//  IdentifiableImage.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import PhotosUI

class IdentifiableImage: Identifiable, Equatable{
    
    //let img: UIImage
    let id: UUID
    let data: NSData
    
    //init(img: UIImage) {
    //    self.img = img
    //    self.id = UUID()
    //}
    
    init(rawData: NSData){
        self.id = UUID()
        self.data = rawData
    }
    
    // Needed for comparisons
    static func == (lhs: IdentifiableImage, rhs: IdentifiableImage) -> Bool {
        return lhs.data.isEqual(rhs.data)
    }
    
}
