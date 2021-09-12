//
//  SearchModels.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 09.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getTracks(searchTerm: String)
            }
        }
        struct Response {
            enum ResponseType {
                case presentTracks(searchResponse: SearchResponce?)
                case presentFooterView
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayTracks(SearchViewModel: SearchViewModel)
                case displayFooterView
            }
        }
    }
}

class SearchViewModel: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(cells, forKey: "cells")
    }
    
    required init?(coder: NSCoder) {
        cells = coder.decodeObject(forKey: "cells") as? [SearchViewModel.Cell] ?? []
    }
    
    @objc(_TtCC11AudioPlayer15SearchViewModel4Cell)class Cell: NSObject, NSCoding, Identifiable {
        
        var id = UUID()
        var iconUrlString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
        var previeUrl: String?
        
        func encode(with coder: NSCoder) {
            coder.encode(iconUrlString, forKey: "iconUrlString")
            coder.encode(trackName, forKey: "trackName")
            coder.encode(collectionName, forKey: "collectionName")
            coder.encode(artistName, forKey: "artistName")
            coder.encode(previeUrl, forKey: "previeUrl")
        }
        
        required init?(coder: NSCoder) {
            iconUrlString = coder.decodeObject(forKey: "iconUrlString") as? String? ?? ""
            trackName = coder.decodeObject(forKey: "trackName") as? String ?? ""
            collectionName = coder.decodeObject(forKey: "collectionName") as? String ?? ""
            artistName = coder.decodeObject(forKey: "artistName") as? String ?? ""
            previeUrl = coder.decodeObject(forKey: "previeUrl") as? String? ?? ""
        }
        
        init(iconUrlString: String?, trackName: String, collectionName: String, artistName: String, previeUrl: String?) {
            
            self.iconUrlString = iconUrlString
            self.trackName = trackName
            self.collectionName = collectionName
            self.artistName = artistName
            self.previeUrl = previeUrl
        }
    }
    
    init(cells: [Cell]) {
        self.cells = cells
    }
    
    let cells: [Cell]
}

