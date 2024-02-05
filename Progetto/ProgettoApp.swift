//
//  ProgettoApp.swift
//  Progetto
//
//  Created by Lorenzo on 29/01/24.
//

import SwiftUI

@main
struct ProgettoApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: IdentifiableText.self)
    }
}
