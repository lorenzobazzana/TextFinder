//
//  TextView.swift
//  TextFinder
//
//  Created by Lorenzo Zanolin on 31/01/24.
//

import SwiftUI
import PhotosUI

struct TextView: View {
    
    @State var canContinue: Bool = false    //used to check wheter the user has selected a text from the list
    let photos : [IdentifiableImage]    //array containing the selected photos by the user; passed from outer view
    
    var body: some View {
        TextDisplayView(photos: photos) //we call another view responsible to visualize the list of texts
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    HStack {
                        Label("Select text", systemImage: "text.justifyleft").labelStyle(.titleAndIcon).font(.headline)
                    }
                }
            }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{}
    }
}
