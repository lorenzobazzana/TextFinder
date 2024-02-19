//
//  IdentifiableImage.swift
//  TextFinder
//
//  Created by Lorenzo Bazzana on 31/01/24.
//

import PhotosUI
import SwiftUI

class IdentifiableImage: Identifiable, Equatable{ //Identifiable is used to identify each single istance in the foreach construct, and as argument to fullScreenCover
    // Equatable is needed to check updates on the image array
    
    let id: UUID        // Image ID
    let data: NSData    // Actual image data
    
    init(rawData: NSData){
        self.id = UUID()
        self.data = rawData
    }
    
    // Needed for comparisons
    static func == (lhs: IdentifiableImage, rhs: IdentifiableImage) -> Bool {
        return lhs.data.isEqual(rhs.data)
    }
    
}

