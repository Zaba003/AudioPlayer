//
//  SearchModels.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 09.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

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

struct SearchViewModel {
    struct Cell: TrackCellViewModel {
        
        var iconUrlString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
        var previeUrl: String?
    }
    
    let cells: [Cell]
}

