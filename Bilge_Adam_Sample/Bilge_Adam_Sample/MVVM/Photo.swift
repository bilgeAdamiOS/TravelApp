//
//  Photo.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 11.08.2023.
//

import Foundation

struct Photos:Codable {
    var photos:[Photo]
}

struct Photo:Codable {
    var id:Int
    var name:String
    var image_url:String
}
