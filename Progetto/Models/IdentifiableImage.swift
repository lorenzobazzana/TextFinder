//
//  IdentifiableImage.swift
//  Progetto
//
//  Created by Lorenzo Bazzana on 31/01/24.
//

import PhotosUI
import SwiftUI

class IdentifiableImage: Identifiable, Equatable{ //Identifiable is used to identify each single istance in the foreach construct
    
    let id: UUID    //identifier
    let data: NSData    //image data
    
    init(rawData: NSData){ //builder
        self.id = UUID()
        self.data = rawData
    }
    
    // Needed for comparisons
    static func == (lhs: IdentifiableImage, rhs: IdentifiableImage) -> Bool {
        return lhs.data.isEqual(rhs.data)
    }
    
}

