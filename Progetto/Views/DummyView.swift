//
//  DummyView.swift
//  Progetto
//
//  Created by Lorenzo on 30/01/24.
//

import SwiftUI

struct DummyView: DisplayView {
    var canContinue: Bool = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DummyView_Previews: PreviewProvider {
    static var previews: some View {
        DummyView()
    }
}
