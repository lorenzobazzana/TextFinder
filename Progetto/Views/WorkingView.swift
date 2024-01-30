//
//  PhotosView.swift
//  Progetto
//
//  Created by Lorenzo on 30/01/24.
//

import SwiftUI

struct WorkingView<Content: View>: View {
    
    let title: String
    let icon: String 
    let displayView: Content
    let nextView: Content
    
    init(title: String, icon: String, displayView: Content, nextView: Content){
        self.title = title
        self.icon = icon
        self.displayView = displayView
        self.nextView = nextView
    }
    
    var body: some View {
            VStack{
                displayView
                //Text("Hello, SwiftUI!")// qua ci va la griglia di foto
                // Idealmente facciamo una cosa tipo
                // Selected photos                    Edit
                // Edit ci permette di selezionarle, aggiungerne o rimuoverle
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal) {
                            HStack {
                                //Image(systemName: "photo.on.rectangle")
                                //Text("Select photos").font(.headline)
                                Label("\(title)", systemImage: "\(icon)").labelStyle(.titleAndIcon).font(.headline)
                            }
                        }
                    }
                Spacer()
                NavigationLink(destination: nextView){
                    Text("Continue")
                        .font(.system(size: 20))
                        .frame(width: 150)
                }.buttonStyle(.bordered)
            }.padding()
    }
}


struct WorkingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WorkingView(title: "Title", icon: "checkmark.seal.fill", displayView: DummyView(), nextView: DummyView())
        }
    }
}
