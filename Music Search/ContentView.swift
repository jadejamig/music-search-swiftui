//
//  ContentView.swift
//  Music Search
//
//  Created by Anselm Jade Jamig on 6/7/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchTerm: $viewModel.searchTerm)
                if self.viewModel.songs.isEmpty{
                    EmptyStateView()
                }
                else {
                    List(self.viewModel.songs) { song in
                        SongView(song: song)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Music Search")
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack() {
            Spacer()
            Image(systemName: "music.note")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start searching for music")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
}

struct ArtworkView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            if image != nil {
                self.image
            } else {
                Color(.systemIndigo)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 50, height: 50)
        .shadow(radius: 5)
        .padding(.trailing, 5)
    }
}

struct SongView: View {
    @ObservedObject var song: SongViewModel
    
    var body: some View {
        HStack {
            ArtworkView(image: song.artwork)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistName)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SongListViewModel())
    }
}
