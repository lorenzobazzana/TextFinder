//
//  ContentView.swift
//  Progetto
//
//  Created by Lorenzo Bazzana on 29/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var photos: [IdentifiableImage] = [] // this will be the array of selected images
    @State var help: Bool = false // used to show and hide the help panel
    
    var body: some View {
        NavigationStack{
            VStack {
                //Spacer()
                let logo = UIImage(named: "uni_logo_blue.png")
                Image(uiImage: logo!)
                //Image(systemName: "globe")
                    //.imageScale(.large)
                    .resizable()
                    .frame(width:150, height:150)
                    .scaledToFit()
                    //.background(.blue)
                    .clipShape(Circle())
                    .offset(y:120)
                Spacer()
                Text("TextFinder")
                    .font(.system(size: 30))
                    .bold()
                NavigationLink(destination: PhotosView(photos: $photos)){ // we pass the binding of photos so that even if we come back to the home screen of the app the selected images are saved
                    Text("Start!")
                        .font(.system(size: 20))
                        .frame(width: 150)
                }
                .buttonStyle(.borderedProminent)
                Button("Help"){
                    help = true
                }
                .offset(y:100)
                .fullScreenCover(isPresented: $help, content: {
                    HelpView(help: $help)
                })
                Spacer()
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
