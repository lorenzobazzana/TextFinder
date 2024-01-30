//
//  ContentView.swift
//  Progetto
//
//  Created by Lorenzo on 29/01/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Prova")
                    .font(.system(size: 30))
                    .bold()
                NavigationLink(destination: WorkingView(title:"Select photos", icon:"photo.on.rectangle", displayView: DummyView(), nextView: DummyView())){
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
