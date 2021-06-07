//
//  Music_SearchApp.swift
//  Music Search
//
//  Created by Anselm Jade Jamig on 6/7/21.
//

import SwiftUI

@main
struct Music_SearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SongListViewModel())
        }
    }
}
