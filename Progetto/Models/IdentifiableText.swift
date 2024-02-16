//
//  IdentifiableText.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 05/02/24.
//

import Foundation
import SwiftData    //text will be saved in the database

@Model
class IdentifiableText : Identifiable{
    //content of the text that is searched in the images
    @Attribute(.unique) var content : String    // unique to avoid duplicates and act as id, var because it can be changed, if edited
    
    init(content: String) {
        self.content = content
    }
}


