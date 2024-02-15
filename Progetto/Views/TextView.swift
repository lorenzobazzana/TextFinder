//
//  TextView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI
import PhotosUI

struct TextView: View {
    
    @State var canContinue: Bool = false    //used to check wheter the user has selected a text from the list
    let photos : [IdentifiableImage]
    
    var body: some View {
        //WorkingView(title: "Select text", icon: "text.justifyleft", displayView: TextDisplayView(), nextView: DummyView(), canContinue: $canContinue)
        TextDisplayView(photos: photos)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    HStack {
                        //Image(systemName: "photo.on.rectangle")
                        //Text("Select photos").font(.headline)
                        Label("Select text", systemImage: "text.justifyleft").labelStyle(.titleAndIcon).font(.headline)
                    }
                }
            }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            //TextView()
        }
    }
}
