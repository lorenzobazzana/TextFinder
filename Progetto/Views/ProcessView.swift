//
//  ProcessView.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 06/02/24.
//

import SwiftUI
import Photos
import PhotosUI

struct ProcessView: View {
    
    var selectedText : String  //this one will be passed from the textView
    @Binding var pickedPhotos : [PhotosPickerItem] //This one will be used to receive the selected photos
    
    var body: some View {
        Text("\(selectedText)")
        Spacer()
        Text("\(pickedPhotos.count)")
    }
}

