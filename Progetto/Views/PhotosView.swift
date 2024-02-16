//
//  PhotosView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI
import PhotosUI

struct PhotosView: View {
    
    @State var canContinue: Bool
    @Binding var photos: [IdentifiableImage]
    let title: String = "Select photos"
    let icon: String = "photo.on.rectangle"
    
    init(photos: Binding<[IdentifiableImage]>){
        self._photos = photos
        self.canContinue = photos.count > 0
    }
    
    var body: some View {
        
        VStack{
            PhotosDisplayView(IDPhotos: $photos)
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
        //.padding()
        .onChange(of: photos){oldPhotos,newPhotos in
            canContinue = newPhotos.count > 0
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
