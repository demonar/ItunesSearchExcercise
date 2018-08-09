//
//  SearchResultTableViewCell.swift
//  Itunes search
//
//  Created by Alejandro Moya on 09/08/2018.
//  Copyright © 2018 Alejandro Moya. All rights reserved.
//

import UIKit
import AlamofireImage


class SearchResultTableViewCell: UITableViewCell {
    static let identifier = "SearchResultTableViewCell"
    
    @IBOutlet var albumArt: UIImageView!
    @IBOutlet var artist: UILabel!
    @IBOutlet var track: UILabel!
    @IBOutlet var contentDescription: UILabel!
    
    var searchElement: SearchElement! {
        didSet {
            self.configureElement()
        }
    }
    
    func configureElement() {
        if let artworkUrl100 = try! self.searchElement.artworkUrl100?.asURL() {
            self.albumArt.af_setImage(withURL: artworkUrl100)
        }
        self.artist.text = self.searchElement.artistName
        self.track.text = self.searchElement.trackName
        self.contentDescription.text = self.searchElement.longDescription
    }
    
}
