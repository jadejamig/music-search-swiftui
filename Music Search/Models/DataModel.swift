//
//  DataModel.swift
//  Music Search
//
//  Created by Anselm Jade Jamig on 6/7/21.
//

import Foundation

// URL structure
// https://itunes.apple.com/search?term=coldplay&entity=song

class DataModel {
    
    private var dataTask: URLSessionDataTask?
    
    func loadSongs(searchTerm: String, completion: @escaping(([Song]) -> Void)) {
        dataTask?.cancel()
        guard let url = self.buildUrl(forTerm: searchTerm) else { completion([]); return}
        
        dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { completion([]); return}
            if let songResponse = try? JSONDecoder().decode(SongResponse.self, from: data) {
                completion(songResponse.songs)
            }
        }
        dataTask?.resume()
    }
    
    // Helper method
    private func buildUrl(forTerm searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else {return nil}
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "song")
        ]
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems = queryItems
        return components?.url
    }
}   


struct Song: Decodable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl = "artworkUrl60"
    }
}

struct SongResponse: Decodable {
    let songs: [Song]
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}
