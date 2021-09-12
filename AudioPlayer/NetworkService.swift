//
//  NetworkService.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 09.09.2021.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponce?) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":"\(searchText)","limit":"100","media":"music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Ошибка получения \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponce.self, from: data)
                //print("objects: ", objects)
                completion(objects)

            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(nil)
            }
//
//            let someString = String(data: data, encoding: .utf8)
//            print(someString ?? "")
        }
    }
}
