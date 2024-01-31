//
//  PhotosDisplayView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI
import Photos
import PhotosUI

struct PhotosDisplayView: View {
    
    @Binding var pickedPhotos : [PhotosPickerItem]
    @State var editing: Bool = false
    var pickerConfig = PHPickerConfiguration()
    var allSelected: Bool = false
    var IDPhotos: [IdentifiableImage] = []
    let grid: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack(alignment: .firstTextBaseline){
                Text("Selected photos")
                    .font(.title)
                .bold()
                Spacer()
                if(editing){
                    Button(action: {}){
                        Text("Select all")
                    }.padding(.trailing)
                }
                else{
                    Button("Edit"){
                        //Text("Edit")
                        editing = true
                    }
                    .padding(.trailing)
                }
                
            }
            //.border(.red)
            //.padding(5)
            //LazyVGrid(columns: grid, spacing: 0){
            //}
            
            Spacer()
            
            if(editing){
                HStack{
                    PhotosPicker(selection: $pickedPhotos,
                                 matching: .images) {
                        Text("Add")
                    }
                    Spacer()
                    Button(action:{}){
                        Text("Remove")
                    }
                    .foregroundColor(.red)
                    Spacer()
                    Button("Cancel"){
                        editing = false
                    }
                }
                .padding(.horizontal)
            }
            Text("Selected \(pickedPhotos.count) photo" + (pickedPhotos.count == 1 ? "" : "s"))
                .padding(.top)
            
        }.onChange(of: pickedPhotos){newPhotos in
            for photo in newPhotos{
                IDPhotos.append(IdentifiableImage(img: photo.loadTransferable(UIImage)))
            }
        }
    }
}

struct PhotosDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosDisplayView(pickedPhotos: .constant([]))
    }
}
