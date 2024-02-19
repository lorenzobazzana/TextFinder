//
//  PhotosView.swift
//  TextFinder
//
//  Created by Lorenzo Bazzana on 31/01/24.
//

import SwiftUI
import PhotosUI

struct PhotosView: View {
    
    @State var canContinue: Bool                // Used to check if the user has selected at least one image
    @Binding var photos: [IdentifiableImage]    // The photos that the user has selected
    let title: String = "Select photos"
    let icon: String = "photo.on.rectangle"
    
    init(photos: Binding<[IdentifiableImage]>){
        self._photos = photos
        self.canContinue = photos.count > 0     // In case the user has gone back to the app home screen we cannot initialize it to false, but we need to check if there are selected photos
    }
    
    var body: some View {
        
        VStack{
            PhotosDisplayView(IDPhotos: $photos) // Manages all the image selection part
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Label("\(title)", systemImage: "\(icon)").labelStyle(.titleAndIcon).font(.headline)
                        }
                    }
                }
            Spacer()
            NavigationLink(destination: TextView(photos: photos)){
                Text("Continue")
                    .font(.system(size: 20))
                    .frame(width: 150)
            }
            .buttonStyle(.bordered)
            .disabled(!canContinue)
        }
        .onChange(of: photos){oldPhotos,newPhotos in
            canContinue = newPhotos.count > 0 // The user can only proceed if at least one photo is selected
        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PhotosView(photos:.constant([]))
        }
    }
}
