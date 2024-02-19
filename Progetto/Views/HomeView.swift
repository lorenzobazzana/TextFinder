//
//  ContentView.swift
//  Progetto
//
//  Created by Lorenzo Bazzana on 29/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var photos: [IdentifiableImage] = []
    @State var help: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                //Spacer()
                let logo = UIImage(named: "uni_logo.png")
                Image(uiImage: logo!)
                //Image(systemName: "globe")
                    //.imageScale(.large)
                    .resizable()
                    .frame(width:150, height:150)
                    .scaledToFit()
                    .background(.blue)
                    .clipShape(Circle())
                    .offset(y:50)
                Spacer()
                Text("TextFinder")
                    .font(.system(size: 30))
                    .bold()
                NavigationLink(destination: PhotosView(photos: $photos)){
                    Text("Start!")
                        .font(.system(size: 20))
                        .frame(width: 150)
                }.buttonStyle(.borderedProminent)
                Button("Help"){
                    help = true
                }
                .offset(y:100)
                .fullScreenCover(isPresented: $help, content: {
                    VStack{
                        Spacer()
                        Text("TextFinder")
                            .font(.title)
                            .bold()
                        Text("This App lets you filter the photos you select by a certain text:")
                        Text("\u{2022} In the \"Select photos\" screen you can select the photos you want to find the text in")
                        Text("\u{2022} In the \"Select text\" screen you can save texts for future use, and select the one you want to find in the photos")
                        Text("\u{2022} After selecting the photos and the text, only the photos containing said text will be shown.")
                        Spacer()
                        Button("Close"){
                            help = false
                        }
                        Spacer()
                    }
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
