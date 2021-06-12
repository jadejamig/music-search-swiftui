//
//  ArtworkLoader.swift
//  Music Search
//
//  Created by Anselm Jade Jamig on 6/8/21.
//

import Foundation
import SwiftUI

class ArtworkLoader {
    private var dataTasks: [URLSessionDataTask] = []
    
    func loadArtwork(forSong song: Song, completion: @escaping((Image?) -> Void)) {
        guard let imageUrl = URL(string: song.artworkUrl) else {completion(nil); return}
        
        let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let artwork = UIImage(data: data) else { completion(nil); return }
            
            let image = Image(uiImage: artwork)
            completion(image)
        }
        
        self.dataTasks.append(dataTask)
        dataTask.resume()
    }
    
    
    func reset() {
        self.dataTasks.forEach { dataTask in
            dataTask.cancel()
        }
    }
}
