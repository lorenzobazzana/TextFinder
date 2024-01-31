//
//  PhotosView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI

struct PhotosView: View {
    var body: some View {
        WorkingView(title: "Select photos", icon: "photo.on.rectangle", displayView: PhotosDisplayView(), nextView: TextView())
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PhotosView()
        }
    }
}
