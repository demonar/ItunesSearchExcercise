//
//  SearchElement.swift
//  Itunes search
//
//  Created by Alejandro Moya on 09/08/2018.
//  Copyright © 2018 Alejandro Moya. All rights reserved.
//

import Foundation
import ObjectMapper

enum SearchType: String {
    case music = "song"
    case tvShow = "tvEpisode"
    case movie = "movie"
    
    var description: String {
        switch self {
        case .music:
            return "Music"
        case .tvShow:
            return "TV show"
        case .movie:
            return "Movie"
        }
    }
    
    static var allDescriptions: [String] {
        return [SearchType.music.description, SearchType.movie.description, SearchType.tvShow.description]
    }
    
    static func typeFromDescription(text: String?) -> SearchType {
        switch text ?? SearchType.music.description {
        case SearchType.movie.description:
            return .movie
        case SearchType.tvShow.description:
            return .tvShow
        default:
            return .music
        }
    }
}

struct SearchElement: Mappable {
    var artistName: String?
    var trackName: String?
    var artworkUrl100: String?
    var longDescription: String?
    var previewUrl: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        artistName <- map["artistName"]
        trackName <- map["trackName"]
        artworkUrl100 <- map["artworkUrl100"]
        longDescription <- map["longDescription"]
        previewUrl <- map["previewUrl"]
    }
}
