//
//  ContentView.swift
//  Progetto
//
//  Created by Lorenzo Bazzana on 29/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var photos: [IdentifiableImage] = []
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Prova")
                    .font(.system(size: 30))
                    .bold()
                NavigationLink(destination: PhotosView(photos: $photos)){
                    Text("Start!")
                        .font(.system(size: 20))
                        .frame(width: 150)
                }.buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
