//
//  PhotosView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI
import PhotosUI

struct PhotosView: View {
    
    @State var canContinue: Bool = false
    @State var photos: [IdentifiableImage] = []
    
    var body: some View {
        WorkingView(title: "Select photos",
                    icon: "photo.on.rectangle",
                    displayView: PhotosDisplayView(IDPhotos: $photos),
                    nextView: TextView(photos: $photos),
                    canContinue: $canContinue)
            .onChange(of: photos){oldPhotos,newPhotos in
                canContinue = newPhotos.count > 0
            }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PhotosView()
        }
    }
}
