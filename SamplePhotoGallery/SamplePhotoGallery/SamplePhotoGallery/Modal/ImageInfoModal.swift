//
//  ImageInfo.swift
//  SamplePhotoGallery
//
//  Created by Ashwini on 23/02/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

struct PhotoInfoElement: Codable {
    
    let id: Int
    let author: String
 

    enum CodingKeys: String, CodingKey {
        case id, author
    
    }
}

typealias PhotoInfo = [PhotoInfoElement]
