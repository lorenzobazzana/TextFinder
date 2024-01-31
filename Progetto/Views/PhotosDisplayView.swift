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
    
    let photos = PHAsset.fetchAssets(with: .image, options: nil)
    @State var editing: Bool = false
    
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
                    Button(action:{editing = true}){
                        Text("Edit")
                    }
                    .padding(.trailing)
                }
                
            }
            //.border(.red)
            //.padding(5)
            Text("Found \(photos.count) photos")
            
            if(editing){
                HStack{
                    Button(action: {}){
                        Text("Add")
                    }
                    Spacer()
                    Button(action:{}){
                        Text("Remove")
                    }
                    .foregroundColor(.red)
                    Spacer()
                    Button(action:{editing = false}){
                        Text("Cancel")
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PhotosDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosDisplayView()
    }
}
