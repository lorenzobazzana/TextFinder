//
//  FullImageView.swift
//  Progetto
//
//  Created by Lorenzo on 14/02/24.
//

import SwiftUI

struct FullImageView: View {
    
    let img: IdentifiableImage
    let width: Int
    let height: Int
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FullImageView(img: IdentifiableImage(rawData: NSData()), width: 0, height: 0)
}
