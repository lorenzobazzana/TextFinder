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
    @State var IDPhotos: [IdentifiableImage] = []
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
            GeometryReader{geometry in
                ScrollView {
                    LazyVGrid(columns: grid, spacing: 2){
                        ForEach(IDPhotos){photo in
                            let img = UIImage(data: photo.data as Data)
                            Image(uiImage:img!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 0.25*geometry.size.width, height: 0.25*geometry.size.width)
                                .clipped()
                            //Text("\(photo.id)")
                        }
                    }
                }//.padding()
            }
            Text("Number of photos: \(IDPhotos.count)")
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
            
        }.task(id: pickedPhotos){
            //IDPhotos = []
            //provare a metterlo in una coda asincrona
            for photo in pickedPhotos{
                if let extractedImage = try? await photo.loadTransferable(type: Data.self){
                    let imageToAppend = IdentifiableImage(rawData: extractedImage as NSData)
                    if !IDPhotos.contains(imageToAppend){
                        IDPhotos.append(imageToAppend)
                    }
                }
                
            }
        }
    }
}

struct PhotosDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        //PhotosDisplayView(pickedPhotos: .constant([]))
        PhotosView()
    }
}
