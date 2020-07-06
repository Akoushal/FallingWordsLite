//
//  Translation.swift
//  FallingWordsLite
//
//  Created by Koushal, KumarAjitesh on 2020/07/06.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

enum Languages {
    case EN
    case ES
}

struct Translation: Codable {
    var text_eng: String
    var text_spa: String
    
    func get(language: Languages?) -> String {
        return language == .EN ? text_eng : text_spa
    }
}
