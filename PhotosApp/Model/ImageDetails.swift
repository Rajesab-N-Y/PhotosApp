//
//  ImageDetails.swift
//  PhotosApp
//
//  Created by Rajesab N Y on 27/05/23.
//

import Foundation

struct ImageDetails: Codable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
}
